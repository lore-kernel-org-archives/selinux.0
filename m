Date: Wed, 28 Jan 2009 08:53:17 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, SELinux@tycho.nsa.gov,
        Stephen Frost <sfrost@snowman.net>
Subject: Re: (forw) [bruce@momjian.us: [ANNOUNCE] Need help on possible PG
 8.4 security features]
In-Reply-To: <497F1839.6@kaigai.gr.jp>
Message-ID: <alpine.LRH.1.10.0901280847210.11866@tundra.namei.org>
References: <20090127012436.GD8123@tamriel.snowman.net> <497EC45D.7090100@ak.jp.nec.com> <alpine.LRH.1.10.0901280020200.8686@tundra.namei.org> <497F1839.6@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Jan 2009, KaiGai Kohei wrote:

> At the LCA example, I assigned sepgsql_fixed_table_t on the
> "drink" table, so newly inserted tuples also inherit it.

Can this type be anything defined by the admin?

Why is MCS being used in the example?  Would anything stop the examples 
using types such as "marketing_department_t" and "research_department_t", 
with no MCS ?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
