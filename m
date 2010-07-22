Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6MD8vwK016005
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2010 09:08:57 -0400
Received: from mail-yx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6MD7rQn011722
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2010 13:07:53 GMT
Received: by yxm8 with SMTP id 8so3028618yxm.12
        for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2010 06:08:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C47CE3A.3090406@ak.jp.nec.com>
References: <4C46B7CF.8090101@ak.jp.nec.com>
	<4C47CE3A.3090406@ak.jp.nec.com>
Date: Thu, 22 Jul 2010 08:01:59 -0500
Message-ID: <AANLkTinYT7RenAg4rQiDkqQG4=VMLcZd_Anf7TeeWxGE@mail.gmail.com>
Subject: Re: memcached with access controls
From: Xavier Toth <txtoth@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>, memcached@googlegroups.com,
        Trond Norbye <trond.norbye@gmail.com>,
        Dustin Sallings <dustin@sallings.org>,
        Toru Maesaka <tmaesaka@gmail.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2010/7/21 KaiGai Kohei <kaigai@ak.jp.nec.com>:
> SELinux folks,
>
> I had a series of discussion with memcached developers.
>
> Memcached is one of the most widely used key-value-store. Nowadays, it is
> not out of common to utilize memcached to boost web-app's performance.
> However, we have unignorable problem from the perspective of system security.
> It does not provide any access control features, although it allows two
> different domains to communicate each other through KVS, because it assumes
> only trusted users and softwares can connect to the memcached server.
> (Yes, it is correct as long as all the clients being trusted.)
>
> As you may know, I've been working on web-application's security with
> LAPP/SELinux stack[1] for a few years. Our assumption is web-applications
> are NOT bug-free, so it may be abused by malicious attackers.
> Thus, I motivated to run web-application with more restricted privileges
> based on centralized, fine-grained and mandatory access control policy.
>
> While the discussion thread, I was informed that the upcoming memcached
> will support a set of interfaces for loadable modules, just called "engine".
> It allows to override the default storage engine which manages key/value
> pairs on the memory. It also means we can apply access controls when it
> tries to access a certain key/value pair within engine modules.
>
> Then, I tries to implement a proof-of-concept module:
>  http://sepgsql.googlecode.com/svn/trunk/memcached/
>  (*) Also see, step to execute [2] below.
>
> Because selinux-policy does not have definitions for key/value pairs now,
> it *abuses* the db_blob object class. So, we need to has a discussion what
> permissions are necessary to control key/value store. Perhaps, its concept
> should be extendable for any other KVS, rather than memcached.
>
> As a draft, I'd like to propose the following set of permissions.
>
>  * kvs_item class
>  - create      ... shall be checked when we try to create a new items.
>  - unlink      ... shall be checked when we try to unlink an existing items.
>  - getattr     ... shall be checked when we try to get properties of items.
>                    (but operations are not defined yet)
>  - setattr     ... shall be checked when we try to set properties of items.
>                    (but operations are not defined yet)
>  - relabelfrom
>  - relabelto   ... shall be checked when we try to relabel items.
>  - read        ... shall be checked when we try to read contents of items.
>  - write       ... shall be checked when we try to update contents of items.
>  - append      ... shall be checked when we try to append/prepend something
>                    on tail/head of existing items. In this case, the contents
>                    of existing item shall be maintained, unlike 'write'.
>  - arithmetic  ... shall be checked when we try to add/sub a certain value
>                    to/from the contents of items, and return the result.
>                    (Perhaps, it is equivalent to combination of read and write)
>  - flush       ... shall be checked when we try to execute 'flush' command
>                    which unlinks all (of expired) items.
>                    It shall be checked on memcached server process, rather
>                    than individual items.
>
>  - default security context
>    Any item does not have its parent object, so we need to decide the way to
>    determine the base context. I think here is two ideas, and my preference
>    is the later one.
>    1. using security context of the memcached process
>    2. using selabel_lookup() facility to set up base context of the memcached.
>
> Please any comments,
>
> Thanks,
>
>
> * memcached and access control
> http://groups.google.com/group/memcached/browse_frm/thread/69560cb93240a3cc
> * A few ideas of engine framework
> http://groups.google.com/group/memcached/browse_frm/thread/cddf18ce141312f1
> * memcached with access controls
> http://groups.google.com/group/memcached/browse_frm/thread/fecb589d945278c9
>
> [1] LAPP/SELinux
> http://sepgsql.googlecode.com/files/PGcon2010-KaiGai-LAPP_SELinux.pdf
>
> [2] Step to execute
> -------------------
> 2-1) build memcached
>  $ git clone git://github.com/trondn/memcached.git -b engine
>  $ cd memcached
>  $ ./config/autorun.sh
>  $ ./configure --prefix=/usr/local/memcached
>  $ make && make install
>  $ cd ..
> 2-2) build selinux_engine.so module
>  $ svn co http://sepgsql.googlecode.com/svn/trunk/memcached/ selinux_engine
>  $ cd selinux_engine
>  $ make && make install
>  $ cd ..
> 2-3) start memcached daemon
>  $ /usr/local/memcached/bin/memcached -E selinux_engine.so -s /tmp/memcached.sock
>
> 2-4) example of memcached with selinux
>  $ runcon -l s0 -- mcdclient.php add key_x 'this is public info' unix:///tmp/memcached.sock
>  success to add [key:key_x, value:this is public info]
>  $ runcon -l s0:c0 -- mcdclient.php add key_y 'this is private info' unix:///tmp/memcached.sock
>  success to add [key:key_y, value:this is private info]
>
>  -> key_x has 's0', and key_y has 's0:c0' in the default.
>
>  $ runcon -l s0 -- mcdclient.php get key_x unix:///tmp/memcached.sock
>  'key_x' => 'this is public info'
>  $ runcon -l s0 -- mcdclient.php get key_y unix:///tmp/memcached.sock
>  no entry for 'key_y'
>  ^^^^^^^^^^^^^^^^^^^^ -> access violation, although error message is incorrect.
>  -> So, 's0' domain can reference key_x, but not key_y.
>
>  $ runcon -l s0:c0 -- mcdclient.php get key_x unix:///tmp/memcached.sock
>  'key_x' => 'this is public info'
>  $ runcon -l s0:c0 -- mcdclient.php get key_y unix:///tmp/memcached.sock
>  'key_y' => 'this is private info'
>
>  -> 's0:c0' domain can reference both key_x and key_y.
>
> --
> KaiGai Kohei <kaigai@ak.jp.nec.com>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

It would be nice if this were generalizable to  all of the
non-relational datastores that have become so popular recently such as
couchdb, mongodb, etc ...

Ted


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
