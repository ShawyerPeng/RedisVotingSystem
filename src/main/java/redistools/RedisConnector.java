package redistools;

import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisConnector {
    private int port = 6379;
    private String host = "127.0.0.1";
    private JedisPool pool;

    public RedisConnector() {
        pool = new JedisPool(new JedisPoolConfig(), this.host, this.port, 2000);
    }

    public JedisPool getPool() {
        return pool;
    }
}