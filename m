Subject: Re: Java Policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <4203B048.5070607@redhat.com>
References: <4203B048.5070607@redhat.com>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 13:02:22 -0500
Message-Id: <1107540182.408.3.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> #  java
> /usr/java/jre.*/bin/java.+ --	system_u:object_r:java_exec_t

That's not where java is on my computer. Jpackage SRPM installs it in
/usr/lib/jvm/jre-1.5.0_01-sun/bin/ 

and then it's linked through the alternatives system:
/usr/bin/java -> /etc/alternatives/java -> 
	/usr/lib/jvm/jre-1.5.0_01-sun/bin/java

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
