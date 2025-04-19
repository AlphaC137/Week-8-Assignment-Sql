from pydantic import BaseModel, EmailStr, constr, Field
from typing import Optional, List
from datetime import datetime

# User schemas
class UserBase(BaseModel):
    username: constr(min_length=3, max_length=50)
    email: EmailStr

class UserCreate(UserBase):
    pass

class UserUpdate(BaseModel):
    username: Optional[constr(min_length=3, max_length=50)] = None
    email: Optional[EmailStr] = None
    is_active: Optional[bool] = None

class UserOut(UserBase):
    id: int
    is_active: bool
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

# Category schemas
class CategoryBase(BaseModel):
    name: constr(min_length=3, max_length=100)
    description: Optional[str] = None

class CategoryCreate(CategoryBase):
    pass

class CategoryUpdate(BaseModel):
    name: Optional[constr(min_length=3, max_length=100)] = None
    description: Optional[str] = None

class Category(CategoryBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

# Task schemas
class TaskBase(BaseModel):
    title: constr(min_length=3, max_length=100)
    description: Optional[str] = None
    is_completed: Optional[bool] = False

class TaskCreate(TaskBase):
    user_id: int
    category_id: Optional[int] = None

class TaskUpdate(BaseModel):
    title: Optional[constr(min_length=3, max_length=100)] = None
    description: Optional[str] = None
    is_completed: Optional[bool] = None
    category_id: Optional[int] = None

class Task(TaskBase):
    id: int
    user_id: int
    category_id: Optional[int]
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

class TaskWithRelations(Task):
    owner: UserOut
    category: Optional[Category] = None

    class Config:
        orm_mode = True