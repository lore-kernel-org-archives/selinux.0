Mime-Version: 1.0
Message-Id: <p06020414bc6d633ab53a@[128.115.96.64]>
Date: Thu, 4 Mar 2004 15:10:04 -0800
To: SELinux@tycho.nsa.gov
From: Mark Shakespeare <mshakes@llnl.gov>
Subject: Running SeLinux on RHEL3 with kernel 2.6.3-2.1.229
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Would appreciate some advice please.....

After successfully getting Fedora and SeLinux to work with my applications,
my boss asked me to make Oracle work under SeLinux.....

Is this possible?????

Here is what I've done....in a nut shell...

Loaded a fresh copy of RHEL3 Enterprise Linux AS....

Found that only Oracle 10g would install on RHEL3....
installation went ok....

Went to Dan Walsh's site and downloaded his Selupgrade script.
Had to make many modifications to script to make it work...
I had the script download kernel 2.6.3-2.1.229 from arjanv's site.

The only way i could get it to build was using

1. checkpolicy-1.6.1 instead of version 1.4-5
2. policycoreutils-1.4.7 instead of version 1.4-3
3. setools-1.2-1 instead of version 1.1.1-1
4. setools-gui-1.2-1 instead of version 1.1.1-1

it mostly works now....

except when I try to do a make relabel

now I get a setfiles invalid context errors....a bunch of them....

Any suggestions are welcome...

Thanks.



							Mark
-- 
******************************************
* Mark Shakespeare			 *
* Engineering Computer Operations Team   *
* Lawrence Livermore National Laboratory *
* 7000 East Ave		L-130            *
* Livermore,Ca 94550			 *
* 925-423-9922	      mshakes@llnl.gov   *
******************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
