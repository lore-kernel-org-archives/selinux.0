Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1LEO3dW017782
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 09:24:03 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1LEJbpm007565
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 14:19:37 GMT
Subject: Re: Java Legacy problem
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, selinux@tycho.nsa.gov
In-Reply-To: <4219E93C.9040005@redhat.com>
References: <1108910713.3610.18.camel@cobra.ivg2.net>
	 <20050220154458.GH14038@lkcl.net> <1108914838.5275.10.camel@cobra.ivg2.net>
	 <20050220171743.GJ14038@lkcl.net>  <4219DB94.1090906@redhat.com>
	 <1108992257.26875.0.camel@cobra.ivg2.net>  <4219E93C.9040005@redhat.com>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 09:24:29 -0500
Message-Id: <1108995869.27158.14.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I don't think java can be fixed,   I think it is doing this stuff by 
>design. 

I thought it was a question of compiling with a newer toolchain that
supports PT_GNU_STACK... is that not the case? 

>A couple of things to try.
>
>How about we rename java_domain to javap_domain (java_plugin).

javap is the java profiler - bad name.

>Then we create a java_domain like the following
>
>define(`java_domain',`
>type $1_java_t, domain, privlog , nscd_client_domain, transitionbool;
>legacy_domain($1_java)
>base_user_domain($1_java)

That looks like a hack - Java is not an actual user. 
You're giving it permissions for user_java_t, while
the whole filesystem is labeled with `respect to user_t.

For example, code that writes to the home directory
still has to write to user_home_t, and you've given
Java permissions to user_java_home_t, which does not
exist in the fs, since java's not a real user. I don't think
this will work.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
