Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76FaxrT012940
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 11:36:59 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76FaOps007774
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 15:36:24 GMT
Date: Fri, 6 Aug 2004 11:36:39 -0400 (EDT)
From: kmacmillan@tresys.com
To: Daniel J Walsh <dwalsh@redhat.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Joshua Brindle <jbrindle@tresys.com>,
   <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   <selinux-dev@tresys.com>
Subject: Re: Now that SELinux supports booleans should we replace tunables
 with booleans?
In-Reply-To: <411397C9.2010606@redhat.com>
Message-ID: <Pine.LNX.4.44.0408061133310.4557-100000@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Aug 2004, Daniel J Walsh wrote:

> Stephen Smalley wrote:
> 
> >On Fri, 2004-08-06 at 10:20, Joshua Brindle wrote:
> >  
> >
> >>If they are going to be changed they should probably also be changed to 
> >>match the get/set convention used by most other selinux apps.
> >>    
> >>
> >
> >I can see renaming change_bool to setsebool or something similar, and
> >adding a new getsebool <boolean> that just displays the value of the
> >specified boolean.  show_bools is a little different in that it shows
> >all booleans and their values, so possibly listsebools.  toggle_sebool
> >has no equivalent.
> >  
> >
> 
> show_bools should be getseboo -a.
> 

This sounds like a good solution to me:

	change_bool	->	setsebool
	show_bools	->	getsebool (with -a showing all)
	toogle_bool	->	togglesebool

Karl

> Dan
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
