from sqlalchemy import Column, Integer, String, ForeignKey, Text, Boolean, DateTime, event
from sqlalchemy.orm import relationship
from database import Base
import datetime

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, nullable=False)
    email = Column(String(100), unique=True, nullable=False)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.datetime.utcnow)

    tasks = relationship("Task", back_populates="owner", cascade="all, delete-orphan")

    def __repr__(self):
        return f"<User(id={self.id}, username='{self.username}')>"


class Category(Base):
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), unique=True, nullable=False)
    description = Column(Text)
    created_at = Column(DateTime, default=datetime.datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.datetime.utcnow)

    tasks = relationship("Task", back_populates="category")

    def __repr__(self):
        return f"<Category(id={self.id}, name='{self.name}')>"


class Task(Base):
    __tablename__ = "tasks"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(100), nullable=False)
    description = Column(Text, nullable=True)
    is_completed = Column(Boolean, default=False)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"))
    category_id = Column(Integer, ForeignKey("categories.id", ondelete="SET NULL"), nullable=True)
    created_at = Column(DateTime, default=datetime.datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.datetime.utcnow)

    owner = relationship("User", back_populates="tasks")
    category = relationship("Category", back_populates="tasks")

    def __repr__(self):
        return f"<Task(id={self.id}, title='{self.title}')>"


# Event listeners for auto-updating timestamps
@event.listens_for(Task, 'before_update')
def receive_before_update(mapper, connection, target):
    target.updated_at = datetime.datetime.utcnow()

@event.listens_for(User, 'before_update')
def user_before_update(mapper, connection, target):
    target.updated_at = datetime.datetime.utcnow()

@event.listens_for(Category, 'before_update')
def category_before_update(mapper, connection, target):
    target.updated_at = datetime.datetime.utcnow()

@event.listens_for(Task, 'before_update')
def task_before_update(mapper, connection, target):
    target.updated_at = datetime.datetime.utcnow()
