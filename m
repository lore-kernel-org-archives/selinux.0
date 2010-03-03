Message-ID: <4B8E72D2.8030802@alanny.ru>
Date: Wed, 03 Mar 2010 17:31:46 +0300
From: AlannY <m@alanny.ru>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Problem with compiling refpolicy base.pp
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi there.

I'm trying to compile refpolicy. I have checkpolicy 2.0.20 and misc
tools (libselinux policycoreutils). I'm trying to:

    make bare
    make conf
    make base.pp

My configuration:

TYPE=mcs
NAME=refpolicy
UNK_PERMS=allow
DIRECT_INITRC=n
MONOLITHIC=n
UBAC=n
MLS_CATS=1024
MCS_CATS=1024

But, the last command failed with the following error:

    Creating refpolicy base module base.conf
    cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf > base.conf
    Compiling refpolicy base module
    /usr/bin/checkmodule -M -U allow base.conf -o tmp/base.mod
    /usr/bin/checkmodule:  loading policy configuration from base.conf
    base.conf:2032:ERROR 'syntax error' at token ':c0.c1023' on line 2032:
    level s0:c0.c1023;

Seems to be, it's a good line (2032), but checkmodule can't eat it.

Where can be the probem?
-- 
   )\._.,--....,'``.
  /,   _.. \   _\  (`._ ,.
 `._.-(,_..'--(,_..'`-.;.'

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
