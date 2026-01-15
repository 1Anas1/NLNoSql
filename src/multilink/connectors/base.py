"""
Base connector interface for all database types
"""

from abc import ABC, abstractmethod
from typing import Dict, List, Any, Tuple


class DatabaseConnector(ABC):
    """Base interface for all database connectors"""
    
    @abstractmethod
    def connect(self) -> bool:
        """Establish connection to database"""
        pass
    
    @abstractmethod
    def introspect_schema(self) -> Dict[str, Any]:
        """Extract schema/metadata from database"""
        pass
    
    @abstractmethod
    def translate(self, nlq: str) -> str:
        """Convert natural language to database query"""
        pass
    
    @abstractmethod
    def validate(self, query: str) -> Tuple[bool, str]:
        """Validate query syntax"""
        pass
    
    @abstractmethod
    def execute(self, query: str) -> List[Dict[str, Any]]:
        """Execute query and return results"""
        pass
    
    @abstractmethod
    def explain(self, nlq: str, query: str, schema: Dict) -> str:
        """Explain how query maps to data model"""
        pass

