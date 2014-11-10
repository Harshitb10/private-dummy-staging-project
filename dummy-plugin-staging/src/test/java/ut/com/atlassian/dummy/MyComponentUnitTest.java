package ut.com.atlassian.dummy;

import org.junit.Test;
import com.atlassian.dummy.MyPluginComponent;
import com.atlassian.dummy.MyPluginComponentImpl;

import static org.junit.Assert.assertEquals;

public class MyComponentUnitTest
{
    @Test
    public void testMyName()
    {
        MyPluginComponent component = new MyPluginComponentImpl(null);
        assertEquals("names do not match!", "myComponent",component.getName());
    }
}