Date: Wed, 28 Jan 2009 00:26:27 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: SELinux@tycho.nsa.gov, Stephen Frost <sfrost@snowman.net>
Subject: Re: (forw) [bruce@momjian.us: [ANNOUNCE] Need help on possible PG
 8.4 security features]
In-Reply-To: <497EC45D.7090100@ak.jp.nec.com>
Message-ID: <alpine.LRH.1.10.0901280020200.8686@tundra.namei.org>
References: <20090127012436.GD8123@tamriel.snowman.net> <497EC45D.7090100@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Jan 2009, KaiGai Kohei wrote:

> It seems to me some of pgsql-hackers concerned about security experts
> don't join to its review process (except for me :), so it is unclear
> whether the SE-PostgreSQL feature is really desired, or not, and
> whether its security design is really appropriate, or not.

It's a pity you couldn't make it to LCA, as I had a question which I 
suspect only you could answer.

One thing I noticed was the use of MCS for labels relating to external 
subjects, and the type field being used apparently for internal purposes.

Is this correct?

(From memory, the type field of some rows were along the lines of
fixed_table_t, presumably for internal db use).

Can the entire security context be specified and utilized for the data 
itself ?  e.g. Can data be inserted into the db with the label 
"system_u:object_r:shadow_t", corresponding exactly to the filesystem 
label of the file it came from?

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
