Subject: RE: file_type_auto_trans is not sufficient
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
   dwalsh@redhat.com
In-Reply-To: <200505311632.j4VGW95F032656@gotham.columbia.tresys.com>
References: <200505311632.j4VGW95F032656@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 31 May 2005 12:48:34 -0400
Message-Id: <1117558114.4455.0.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I know - that is why I am suggesting that each application could use multiple
> directories. That means that orbit might put files into multiple directories
> that were previously created, e.g. both /tmp and /tmp/orbit.

I am not following this - can you give an example.

Say you have an application such as gconf, which stores its data 
in /tmp/gconfd-$USER (so it needs to be able to create that). 
GConf is linked to libORBit2, hence it needs to be able to
create /tmp/orbit-$USER.

Running gconfd in an individual domain is possible (and that's exactly
what I've done). Running orbit in its domain does not work (at least not
without a dynamic transition), because it's library code.

Are you saying that either gconfd or orbit need to move their files
outside their designated directory and into /tmp?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
