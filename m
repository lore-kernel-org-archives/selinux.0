Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4L3pnRb025135
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 23:51:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4L3pkAR023080
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 03:51:47 GMT
Received: from web41013.mail.yahoo.com (web41013.mail.yahoo.com [66.218.93.12])
        by jazzband.ncsc.mil  with SMTP id i4L3pkHn023077 for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 03:51:46 GMT
Message-ID: <20040521035145.81148.qmail@web41013.mail.yahoo.com>
Date: Thu, 20 May 2004 20:51:45 -0700 (PDT)
From: K Vikram <vikramatiitkdotacdotin@yahoo.com>
Subject: Loadable Policy Modules and a Generic MAC Policy Language
To: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1874603885-1085111505=:79008"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1874603885-1085111505=:79008
Content-Type: text/plain; charset=us-ascii


Hello,
A few months ago we had become interested in SELinux and began experimenting with it. While working with it, we got particularly interested in the policy specification process and how cumbersome or unwieldy it could turn out for a high level policy model. We felt that the restriction to the TE language was complicating things a little and went on to investigate what would happen if we remove this restriction.
We worked out a design with three key mechanisms that we felt would be useful, but not too powerful. We are now finally done with the implementation of these mechanisms. We have made the necessary changes in the code of SELinux and the use of any of these mechanisms does not require any further change in SELinux code.The first mechanism is that of being able to associate arbitrary security related information, other than user:role:type, with each subject/object in the system. This would be useful, for instance, if we would want an MLS enforcement. Here we would simply associate the appropriate levels and categories with each subject/object.
The second mechanism is the ability to express what operations should be allowed and what should not, by expressing it as C code. This C code would be in the form of definitions of certain specified interface functions and is written as a loadable kernel module. The interface is fixed and has been designed to be just powerful enough to be able to express most MAC policies and simple enough so that writing definitions for it does not require detailed knowledge of SELinux internals.
The C code written would also contain information as to what kind/type of data should be associated with a subject/object (refer the first mechanism discussed above). The precise value of the data and the other system specific configuration values could be optionally stored in a configuration file and loaded into memory so that the module can read it when required. This configuration file would be analogous to the policy binary file in SELinux.
The third mechanism helps us to compose the decisions of many such modules. The mode of composition has been kept flexible and could be in the form of an arbitrary boolean function with as many variables as the number of modules.
Being able to express policies as C code did seem to have certain advantages. For instance, the expression of the MLS model or the Biba model was made fairly succinct with the help of less-than and greater-than operators. This succintness also made it easier for us to understand and analyze such C-code policy specifications ourselves.
The feature of composition of modules also seemed to work neatly. We implemented Lipner's Integrity Matrix Model, simply as an AND combination of BLP and Biba modules without expending any extra effort.
However, we did feel that C code for expressing policies is certainly overkill. So we also began working on a high level language that could express most MAC policies and a translator would translate this to C code. This C code can then be compiled into a loadable kernel module that could be attached to the kernel. This part of the work is yet not complete, but we hope to finish it soon.Nevertheless, some key features of such a language would be that it would have just a couple of data types such as integers and strings (these would be the types of data that could be associated with a subject/object) and few operators on such data types such as relational and logical operators, a few simple set operators and maybe a couple of simple string related operators. The language would also contain constructs to compose the decisions of many such modules. There would be no recursion in the language so that the generated module would execute efficiently.
The above mechanisms are definitely not a replacement to the TE model. Rather it acts as a supplement. The TE language is good enough for a lot of cases, but cases where TE is not powerful enough or does not seem appropriate, a more generic MAC policy language might be necessary. That is what we intend to provide. The motto is "Use TE where appropriate, and use a more generic MAC policy language where it is not." Note that using the above mechanisms is completely optional. If and only if a policy writer finds TE unwieldy, would he use the more generic language.
It has to be investigated where this would be useful. For one thing, we found such a generic MAC policy language much more convenient than TE, for MLS and Biba kind of security models.
Another area of investigation would be that of policy analysis. Policy analysis in this generic language seems difficult but definitely doable. At least for a human, analysis might seem easier, but whether automated analysis can be done efficiently has to be looked at.
We would eager to have comments/suggestions/criticisms from the group about our work. If people are interested, we can share our code as well, but it would take a couple of days before we can package it well. As aforesaid, the three basic mechanisms have been implemented and we can share that code. However, the generic language details and the translator have still not been worked out completely but they are not crucial to the use of the three mechanisms.
Other than kernel code, relevant patches to userspace programs such as login, init, setfiles, etc. and loadable kernel modules for Biba, BLP and Lipner models are also included. These patches were required to fully implement and use the above mechanisms.
		
---------------------------------
Do you Yahoo!?
Yahoo! Domains - Claim yours for only $14.70/year
--0-1874603885-1085111505=:79008
Content-Type: text/html; charset=us-ascii

<p>Hello,

<p>A few months ago we had become interested in SELinux and began experimenting with it. While working with it, we got particularly interested in the policy specification process and how cumbersome or unwieldy it could turn out for a high level policy model. We felt that the restriction to the TE language was complicating things a little and went on to investigate what would happen if we remove this restriction.

<p>We worked out a design with three key mechanisms that we felt would be useful, but not too powerful. We are now finally done with the implementation of these mechanisms. We have made the necessary changes in the code of SELinux and the use of any of these mechanisms does not require any further change in SELinux code.
The first mechanism is that of being able to associate arbitrary security related information, other than user:role:type, with each subject/object in the system. This would be useful, for instance, if we would want an MLS enforcement. Here we would simply associate the appropriate levels and categories with each subject/object.

<p>The second mechanism is the ability to express what operations should be allowed and what should not, by expressing it as C code. This C code would be in the form of definitions of certain specified interface functions and is written as a loadable kernel module. The interface is fixed and has been designed to be just powerful enough to be able to express most MAC policies and simple enough so that writing definitions for it does not require detailed knowledge of SELinux internals.

<p>The C code written would also contain information as to what kind/type of data should be associated with a subject/object (refer the first mechanism discussed above). The precise value of the data and the other system specific configuration values could be optionally stored in a configuration file and loaded into memory so that the module can read it when required. This configuration file would be analogous to the policy binary file in SELinux.

<p>The third mechanism helps us to <i>compose</i> the decisions of many such modules. The mode of composition has been kept flexible and could be in the form of an arbitrary boolean function with as many variables as the number of modules.

<p>Being able to express policies as C code did seem to have certain advantages. For instance, the expression of the MLS model or the Biba model was made fairly succinct with the help of less-than and greater-than operators. This succintness also made it easier for us to understand and analyze such C-code <i>policy specifications</i> ourselves.

<p>The feature of composition of modules also seemed to work neatly. We implemented Lipner's Integrity Matrix Model, simply as an AND combination of BLP and Biba modules without expending any extra effort.

<p>However, we did feel that C code for expressing policies is certainly overkill. So we also began working on a high level language that could express most MAC policies and a translator would translate this to C code. This C code can then be compiled into a loadable kernel module that could be attached to the kernel. This part of the work is yet not complete, but we hope to finish it soon.
Nevertheless, some key features of such a language would be that it would have just a couple of data types such as integers and strings (these would be the types of data that could be associated with a subject/object) and few operators on such data types such as relational and logical operators, a few simple set operators and maybe a couple of simple string related operators. The language would also contain constructs to compose the decisions of many such modules. There would be no recursion in the language so that the generated module would execute efficiently.

<p>The above mechanisms are definitely not a replacement to the TE model. Rather it acts as a supplement. The TE language is good enough for a lot of cases, but cases where TE is not powerful enough or does not seem appropriate, a more generic MAC policy language might be necessary. That is what we intend to provide. The motto is "Use TE where appropriate, and use a more generic MAC policy language where it is not." Note that using the above mechanisms is completely optional. If and only if a policy writer finds TE unwieldy, would he use the more generic language.

<p>It has to be investigated where this would be useful. For one thing, we found such a generic MAC policy language much more convenient than TE, for MLS and Biba kind of security models.

<p>Another area of investigation would be that of policy analysis. Policy analysis in this generic language seems difficult but definitely doable. At least for a human, analysis might seem easier, but whether automated analysis can be done efficiently has to be looked at.

<p>We would eager to have comments/suggestions/criticisms from the group about our work. If people are interested, we can share our code as well, but it would take a couple of days before we can package it well. As aforesaid, the three basic mechanisms have been implemented and we can share that code. However, the generic language details and the translator have still not been worked out completely but they are not crucial to the use of the three mechanisms.

<p>Other than kernel code, relevant patches to userspace programs such as login, init, setfiles, etc. and loadable kernel modules for Biba, BLP and Lipner models are also included. These patches were required to fully implement and use the above mechanisms.

<p>
		<hr size=1><font face=arial size=-1>Do you Yahoo!?<br>Yahoo! Domains - <a href="http://us.rd.yahoo.com/evt=23613/*http://smallbusiness.promotions.yahoo.com/offer">Claim yours for only $14.70/year</a>
--0-1874603885-1085111505=:79008--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
