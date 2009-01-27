Message-ID: <497F9673.4060407@kaigai.gr.jp>
Date: Wed, 28 Jan 2009 08:19:15 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, SELinux@tycho.nsa.gov,
        Stephen Frost <sfrost@snowman.net>
Subject: Re: (forw) [bruce@momjian.us: [ANNOUNCE] Need help on possible PG
 8.4 security features]
References: <20090127012436.GD8123@tamriel.snowman.net> <497EC45D.7090100@ak.jp.nec.com> <alpine.LRH.1.10.0901280020200.8686@tundra.namei.org> <497F1839.6@kaigai.gr.jp> <alpine.LRH.1.10.0901280847210.11866@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0901280847210.11866@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 27 Jan 2009, KaiGai Kohei wrote:
> 
>> At the LCA example, I assigned sepgsql_fixed_table_t on the
>> "drink" table, so newly inserted tuples also inherit it.
> 
> Can this type be anything defined by the admin?

YES, as follows:

CREATE TABLE drink (
   id   integer primary key,
   name text security_label = 'system_u:object_r:example_foo_t',
   price integer
) security_label = 'system_u:object_r:example_var_t';

It enables to create a table/columns with specified context.

and,

INSERT INTO drink (security_label, id, name, price)
   VALUES ('system_u:object_r:example_baz_t', 1, 'coffee', 120);

It enables to insert a tuple with specified context.

(*) security_label is a system column, so it automatically
     generated for all tables, and not expanded by "SELECT *".

> Why is MCS being used in the example?  Would anything stop the examples 
> using types such as "marketing_department_t" and "research_department_t", 
> with no MCS ?

It is possible, if we make an example policy module.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
