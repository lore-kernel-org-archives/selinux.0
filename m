Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1LEwOdW017943
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 09:58:24 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1LEuG3J028990
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 14:56:17 GMT
Date: Mon, 21 Feb 2005 15:06:09 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Java Legacy problem
Message-ID: <20050221150609.GV14038@lkcl.net>
References: <1108910713.3610.18.camel@cobra.ivg2.net> <20050220154458.GH14038@lkcl.net> <1108914838.5275.10.camel@cobra.ivg2.net> <20050220171743.GJ14038@lkcl.net> <4219DB94.1090906@redhat.com> <1108992257.26875.0.camel@cobra.ivg2.net> <4219E93C.9040005@redhat.com> <1108995869.27158.14.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108995869.27158.14.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 21, 2005 at 09:24:29AM -0500, Ivan Gyurdiev wrote:
> 
> >I don't think java can be fixed,   I think it is doing this stuff by 
> >design. 
> 
> I thought it was a question of compiling with a newer toolchain that
> supports PT_GNU_STACK... is that not the case? 
> 
> >A couple of things to try.
> >
> >How about we rename java_domain to javap_domain (java_plugin).
> 
> javap is the java profiler - bad name.
> 
> >Then we create a java_domain like the following
> >
> >define(`java_domain',`
> >type $1_java_t, domain, privlog , nscd_client_domain, transitionbool;
> >legacy_domain($1_java)
> >base_user_domain($1_java)
> 
> That looks like a hack 

 not sure.

> - Java is not an actual user. 
 
 the concept of user doesn't exist in selinux, only domains,
 contexts etc.

 therefore this statement is rather ambiguous: could you possibly
 clarify, just for the record?

> You're giving it permissions for user_java_t, while
> the whole filesystem is labeled with `respect to user_t.

 or more specifically, user_t is given certain rights to access
 specific parts of the filesystem, whereas at present,
 user_java_t is given none, yes?

 so... that suggests that user_java_t should be given some, yes?

> For example, code that writes to the home directory
> still has to write to user_home_t, and you've given
> Java permissions to user_java_home_t, which does not
> exist in the fs, since java's not a real user. I don't think
> this will work.
 
 two, maybe three options are available:

 1) typealias user_java_home_t to user_home_t

 2) run it, go looking for places where $1_home_t is used
    and where _appropriate_ add $1_java_home_t as well.

    mostly these places will be in user_macros, and you'd
    do instead of oh i dunno:

	    allow xdm_t $1_home_t:lnk_file read;
    
    you'd do this:

	    allow xdm_t { $1_home_t $1_java_home_t} :lnk_file read; 

    (except that's possibly a bad example).

 3) don't use base_user_domain() although i wouldn't have a 
    clue what to put in its place.


 i'm not sure what daniel intends by the use of base_user_domain()
 so i can't really say if 2) is actually appropriate or not.

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
