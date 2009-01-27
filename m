Message-ID: <497F1839.6@kaigai.gr.jp>
Date: Tue, 27 Jan 2009 23:20:41 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, SELinux@tycho.nsa.gov,
        Stephen Frost <sfrost@snowman.net>
Subject: Re: (forw) [bruce@momjian.us: [ANNOUNCE] Need help on possible PG
 8.4 security features]
References: <20090127012436.GD8123@tamriel.snowman.net> <497EC45D.7090100@ak.jp.nec.com> <alpine.LRH.1.10.0901280020200.8686@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0901280020200.8686@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 27 Jan 2009, KaiGai Kohei wrote:
> 
>> It seems to me some of pgsql-hackers concerned about security experts
>> don't join to its review process (except for me :), so it is unclear
>> whether the SE-PostgreSQL feature is really desired, or not, and
>> whether its security design is really appropriate, or not.
> 
> It's a pity you couldn't make it to LCA, as I had a question which I 
> suspect only you could answer.
> 
> One thing I noticed was the use of MCS for labels relating to external 
> subjects, and the type field being used apparently for internal purposes.
> 
> Is this correct?
> 
> (From memory, the type field of some rows were along the lines of
> fixed_table_t, presumably for internal db use).

There are no specific discrimination like internal/external.
SE-PostgreSQL simply assigns a default security context based
on type_transition rules, or inherits upper class obejct.

At the LCA example, I assigned sepgsql_fixed_table_t on the
"drink" table, so newly inserted tuples also inherit it.

> Can the entire security context be specified and utilized for the data 
> itself ?  e.g. Can data be inserted into the db with the label 
> "system_u:object_r:shadow_t", corresponding exactly to the filesystem 
> label of the file it came from?

Please consider the following case.
  1. App-X read /etc/shadhow (system_u:object_r:shadow_t)
  2. App-X create a file /tmp/aaa
  3. App-X write a buffered data into /tmp/aaa
In this case, /tmp/aaa will be labeled as "tmp_t".

  1'. App-X read /etc/shadhow (system_u:object_r:shadow_t)
  2'. App-X insert a row with buffered data.
In this case, I don't think it should be labeled as "shadow_t".
The newly inserted row is labeled based on TYPE_TRANSITION, or
inherits its table's context.
(Maybe, "sepgsql_table_t" in default)

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
