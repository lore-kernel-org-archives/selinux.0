Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KCbPAd019385
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 07:37:25 -0500
Received: from www346.sakura.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KCceOC026801
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 12:38:41 GMT
Message-ID: <45DAEBB8.40208@ak.jp.nec.com>
Date: Tue, 20 Feb 2007 21:38:16 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [RFC] Security design of SE-PostgreSQL (2/3)
References: <45D542AF.1030108@kaigai.gr.jp> <200702191750.31301.russell@coker.com.au> <45DA5829.7060800@ak.jp.nec.com> <200702202045.24263.russell@coker.com.au>
In-Reply-To: <200702202045.24263.russell@coker.com.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Tuesday 20 February 2007 13:08, KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:
>>> What Unix access controls are applied?  I guess that as PostgreSQL users
>>> don't have a direct relationship with Unix users it can't check the UID
>>> so it's just a matter of what files the database server has read and
>>> execute to which are in that directory.
>>>
>>> Does it just check to make sure that the file isn't a sym-link and isn't
>>> world-writable.
>> UNIX access controls are applied between the PostgreSQL server process UID
>> and shared library files, independent from client process's UID.
> 
> Do you mean that it just opens the file and relies on Unix permissions to 
> determine whether the open succeeds?

Yes,
The only limitation is that shared library files loaded by non-privileged
database user must be deployed under "$libdir/plugins/".

>> A sym-link checking is done, but its purpose is to avoid to load a same
>> shared library file twice or more.
> 
> That's not going to work very well.  Checking st_ino and st_dev is the only 
> reliable way of doing it.  But I guess if they are only dealing with mistakes 
> and not malicious actions then it's OK (of course it's easier to check two 
> integers than multiple sym-links).

Ahh, I'm sorry for misunderstanding.
I wanted to say that PostgreSQL allows to deploy a symlink-file under the plugins
directory. It uses st_ino and st_dev from star() to check duplication.

>>> Other programs might need such triples in the policy, I wonder if it
>>> would be possible to make this a generic language feature.  Some sort of
>>> policy class which instead of actions takes another type as the third
>>> parameter.
>> I think it should be resolved by macros in the reference policy period.
>>
>> e.g)
>>    sepgsql_enable_load_shlib(db_client_t, sepgsql_t, shlib_t)
>>      =>  allow db_client_t sepgsql_db_t : database { load_module };
>>          allow sepgsql_db_t shlib_file_t : database { associate };
>>          allow db_client_t shlib_file_t : database { load_module };
> 
> Yes, that will work.  However there might be benefits in other situations as 
> well for extending the policy language...

It might give us benefits, but I like to focus SE-PostgreSQL works now...

So, I like to make it progress with the following design:
     client  <--> database   requires 'database:install_module'
     client  <--> shlib file requires 'database:install_module'
    database <--> shlib file requires 'database:load_module'

The name of access vector was changed. Maybe, the aboves are more suitable.

Thanks,
--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
