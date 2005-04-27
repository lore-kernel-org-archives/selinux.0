Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3RE9fgA016901
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 10:09:42 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3RE9XCp029686
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 14:09:33 GMT
Subject: Re: /tmp
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
In-Reply-To: <1114610043.21998.16.camel@localhost.localdomain>
References: <1114610043.21998.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 10:09:23 -0400
Message-Id: <1114610963.21998.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> It seems like all those folders should be created ahead of time (login
> script? tmp could be on tmpfs), and their context set to the right thing
> - but the right thing should be in the policy - should be able to use
> restorecon on those files. Couldn't such tmp files be made to work
> similarly to the home directories? Any suggestions?

So couldn't a new expansion be added called USER that expands to the
corresponding user name?

/tmp                   <<none>>
/tmp/orbit-USER        system_u:object_r:ROLE_orbit_tmp_t
/tmp/gconfd-USER       system_u:object_r:ROLE_gconfd_tmp_t
/tmp/scrollkeeper-USER system_u:object_r:ROLE_scrollkeeper_tmp_t
/tmp/hsperfdata_USER   system_u:object_r:ROLE_java_tmp_t
/tmp/.esd              system_u:object_r:esd_tmp_t

And then, in /etc/profile.d/selinux.sh, create a whole bunch of those
folders, or restorecon existing ones? 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
