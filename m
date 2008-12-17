Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBHEt2qC006555
	for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2008 09:55:02 -0500
Received: from hrndva-omtalb.mail.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBHEsvkP013699
	for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2008 14:55:02 GMT
Received: from lanikea.austin.rr.com ([70.116.65.78])
          by hrndva-omta06.mail.rr.com with ESMTP
          id <20081217145457.LDUN24374.hrndva-omta06.mail.rr.com@lanikea.austin.rr.com>
          for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2008 14:54:57 +0000
Message-Id: <CAF3C53F-C7C9-419C-9F2A-F7D5BB48AF64@austin.rr.com>
From: Nick Gray <nick@austin.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Tar problems when restoring polyinstantiated directories
Date: Wed, 17 Dec 2008 08:54:56 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am noticing an error from Tar when trying to restore  
polyinstantiated directories. Rather than try to go into verbal detail  
I though I would include the test example that I ran

-----------
As root

mkdir /TEST
mkdir /TEST/poly
mkdir /TEST/poly.inst
mkdir /TEST/single
chmod -R 777 /TEST
Edit /etc/security/namespace.conf and add

/TEST/poly /TEST/poly.inst/ level:shared:noinit:create=0777,,nick  root

reboot

open a terminal as nick

newrole -l "SECRET-SECRET"
touch /TEST/poly/SECRET
touch /TEST/single/SECRET

exit back to SystemLow
su -
cd /
tar cv --xattrs -f test.tar /TEST

rm -r /TEST/* (This will give "rm: cannot remove directory `/TEST/ 
poly': Device or resource busy")

note that /TEST/poly.inst and single are gone.

tar xf test.tar

tar: TEST/poly.inst/78d20e47cbefd4885c856413327b3acb: Warning: Cannot  
acl_from_text: Invalid argument
tar: TEST/poly.inst/0cd9e1d91636475b2aa52c5c8ba08a22: Warning: Cannot  
acl_from_text: Invalid argument

The directories have been restored, and the SECRET file in poly has  
been restored, is accessible and only visbile by nick at SECRET-SECRET
-----------

Gladly appreciate any comments. I will look into the source when I get  
a chance and see if I can get more information.

Thanks Nicks.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
