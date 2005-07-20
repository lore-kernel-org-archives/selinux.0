Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6K9xqgA014571
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 05:59:52 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6K9sg9b007069
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 09:54:42 GMT
Date: Wed, 20 Jul 2005 10:55:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov,
   dwalsh@redhat.com
Subject: Re: SElinux nss/nscd service
Message-ID: <20050720095524.GK8851@lkcl.net>
References: <1121794572.4780.15.camel@celtics.boston.redhat.com> <200507191825.j6JIPsvx013481@gotham.columbia.tresys.com> <20050719215424.GA8851@lkcl.net> <1121815377.15541.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121815377.15541.15.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 19, 2005 at 07:22:57PM -0400, Ivan Gyurdiev wrote:
> On Tue, 2005-07-19 at 22:54 +0100, Luke Kenneth Casson Leighton wrote:
> > could someone do me a large favour, and point me at a URL which
> > contains a description of JUST the requirements - formal or informal
> > specification, i don't mind which - and a brief contextual outline
> > or references to archives.
> 
> Luke, there is no specification at the moment. 

 ... that's one of the reasons why i asked :)

 i've been skimming the posts coming in, and the ones with "eek, we're
 giving up and backing out" caught my attention.

 i started re-reading, and i am thinking that this whole
 thing looks very "winbindd" like, which i helped design
 (i had to bypass andrew in order for the design to be
 correct.  it's a long story).  tim potter implemented it,
 using samba-tng's rpcclient libraries.

 yes, there were discussions about enhancing nsswitch with NT-like
 domain functionality: these ideas were abandoned on the grounds that
 they were unlikely to be accepted.


 okay, am switching mentally to formal "PITA" mode
 [like i have any other...]

> We're simply 
> following up on Karl's idea to map Unix users to SElinux users
> in a different fashion than 1:1 with user_u fallback. 

 okay.  that still doesn't quite feel like "requirements spec"
 material to me: the bit with "idea" says to me that it's been
 proposed but not formally accepted as "required".


 also the sentence is ambiguous, missing a comma.

 do you mean map unix users to selinux users in different fashion than
 "1:1 with user_u fallback"

 or 

 do you mean map unix users to selinux users "in different fashion than
 1:1", with user_u fallback.


> Instead
> we will be mapping many Unix users to few SElinux users,
> which may also be called security "classes". The default
> class would also be configurable (not hardcoded on user_u).

 sounds good (and also after a bit of thought for 10 mins it
 clears up the abiguity above)

 is this "requirements specification" or "functional spec"?

 okay.

 so a better way to put this is:

	we will be mapping many Unix users to few SElinux users,
	which may also be called security "classes".
	
	all users not explicitly mapped will be given the
	default "class", which itself will be configurable,
	and itself defaults to "user_u".

 

> This is a good idea, because it improves scalability - the 
> users no longer need to be stored in the kernel and eat up
> memory. Instead, we will only store users (classes) that have
> different security properties. Additionally, we will no longer 
> need to reload the security policy to change the roles for a 
> user - instead we'd just remap her to a different security class.

 still sounding eminently sensible.

> --
> 
> The discussion here is about how exactly to accomplish that - 
> where would the code be placed that interprets this map
> (which will store user, selinux user, and mls categories
> for the user, which we decided are important to keep per user)

 this is where things are sounding eminently winbindd-like.

 winbindd keeps (actually, generates according to some config
 options in smb.conf and then persistently keeps) a map between
 unix users and NT Domain Users, and also a map between unix
 groups and NT Domain Groups (both local and global).

 then there's pam_winbindd which communicates with winbindd and reads
 that map.

 and there's nss_winbind which does likewise.


> Originally I wrote some code for libselinux/libsemanage, 
> but Karl didn't like that (and still doesn't) so an alternative was 
> explored to provide a standard glibc interface, similar to 
> getpwnam() that makes use of nsswitch.conf. However, it now 
> seems that this is a mistake. 

 based on the experience of winbindd, i believe / predict that
 you will find that the only mistake was to imagine that this can all
 be done as a library rather than a service.

 ... but i'm not that good at priddidictions.


> It is also being proposed to 
> place this code in pam, but I don't see how this will work at 
> all - if you place code in pam, than all the code that doesn't
> use pam (and there's already a few planned callers - admin
> programs) cannot make use of it, and has to write its 
> own interface.

 again: the provision of a winbindd-like service will allow you to write
 a pam module that reads the persistent information from the service.


 winbindd has a unix domain socket over which communication is carried
 out - pam_winbindd, nss_winbindd and, in the version of winbindd
 present in samba tng, freedce's ntlmsspauth.so as well.

 no, this unix domain socket should not be accessible by anything other
 than root.


 the only key difference i can see between winbindd and what
 you are proposing is that winbindd's "mapping" system is
 one-to-one and onto (i know there's a special word for that
 but i can't remember what it is).

 whereas what _you_ require is many to one mapping - from unix
 users to security "classes".

 ... you're implementing groups :)
 
 wot i noticed was missing and asked about, when i first looked
 at selinux :)

 l.

--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
