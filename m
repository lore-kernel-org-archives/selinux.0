Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA2FL6dM016394
	for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2011 11:21:06 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pA2FL4us004948
	for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2011 15:21:05 GMT
Message-ID: <1320247235.11464.12.camel@localhost>
Subject: Re: [PATCH 01/63] checkpolicy: the " is not part of the filename for
From: Eric Paris <eparis@redhat.com>
To: Steve Lawrence <slawrence@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Date: Wed, 02 Nov 2011 11:20:35 -0400
In-Reply-To: <4EB136C3.9030205@tresys.com>
References: <4EB047C7.2060703@redhat.com> <4EB136C3.9030205@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-11-02 at 08:25 -0400, Steve Lawrence wrote:
> On 11/01/2011 03:25 PM, Daniel J Walsh wrote:
> > 
> > OpenPGP: *Attachments to this message have not been signed or encrypted*
> > 
> > ********* *BEGIN ENCRYPTED or SIGNED PART* *********
> > 
> > 
> > This patch looks good to me. acked.
> > 
> > 
> > ********** *END ENCRYPTED or SIGNED PART* **********
> > 
> > 0001-checkpolicy-the-is-not-part-of-the-filename-for-tran.patchFrom c3ba40d2e17186d702a6ea2b83e185603dafa06f Mon Sep 17 00:00:00 2001
> > From: Dan Walsh <dwalsh@redhat.com>
> > Date: Tue, 20 Sep 2011 09:52:57 -0400
> > Subject: [PATCH 01/63] checkpolicy: the " is not part of the filename for
> >  trans rules
> > 
> > Policy decided that all filenames needed to be wrapped in " in the
> > filename trans rules.  But we weren't doing anything with those in the
> > language syntax and instead just passed the " to the kernel as if the
> > filename in question were actually  \"file\".  Add the " to the policy
> > grammer.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> >  checkpolicy/policy_parse.y |    4 ++--
> >  checkpolicy/policy_scan.l  |    2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index 49ac15f..1e3ef6f 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -353,7 +353,7 @@ cond_rule_def           : cond_transition_def
> >  			| require_block
> >  			{ $$ = NULL; }
> >                          ;
> > -cond_transition_def	: TYPE_TRANSITION names names ':' names identifier filename ';'
> > +cond_transition_def	: TYPE_TRANSITION names names ':' names identifier '\"' filename '\"' ';'
> >                          { $$ = define_cond_filename_trans() ;
> >                            if ($$ == COND_ERR) return -1;}
> >  			| TYPE_TRANSITION names names ':' names identifier ';'
> > @@ -391,7 +391,7 @@ cond_dontaudit_def	: DONTAUDIT names names ':' names names ';'
> >  			{ $$ = define_cond_te_avtab(AVRULE_DONTAUDIT);
> >                            if ($$ == COND_ERR) return -1; }
> >  		        ;
> > -transition_def		: TYPE_TRANSITION  names names ':' names identifier filename ';'
> > +transition_def		: TYPE_TRANSITION  names names ':' names identifier '\"' filename '\"' ';'
> >  			{if (define_filename_trans()) return -1; }
> >  			| TYPE_TRANSITION names names ':' names identifier ';'
> >                          {if (define_compute_type(AVRULE_TRANSITION)) return -1;}
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index a61e0db..2ba5971 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -227,7 +227,6 @@ PERMISSIVE			{ return(PERMISSIVE); }
> >  {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
> >  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
> >  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> > -\"({alnum}|[_\.\-])+\"		{ return(FILENAME); }
> >  {alnum}*                        { return(FILENAME); }
> >  \.({alnum}|[_\.\-])*	        { return(FILENAME); }
> >  {letter}+([-_\.]|{alnum})+      { return(FILENAME); }
> > @@ -253,6 +252,7 @@ PERMISSIVE			{ return(PERMISSIVE); }
> >  "-" |
> >  "." |
> >  "]" |
> > +"\"" |
> >  "~" |
> >  "*"				{ return(yytext[0]); } 
> >  .                               { yywarn("unrecognized character");}
> > -- 1.7.7
> 
> 
> I believe this shouldn't be necessary, and it looks like that's because
> a patch was committed that shouldn't have been.
> 
> 
> This was the original filename commit:
> 
>   commit d4c230386653db49d8e8116b603efcce4423df70
>   Author: Daniel J Walsh <dwalsh@redhat.com>
>   Date:   Fri Apr 29 15:29:48 2011 -0400
> 
>       checkpolicy: use a better identifier for filenames
> 
> That commit was reverted and changed to require a quote around filenames
> (which did the quote stripping) in this commit:
> 
>   commit b42e15ffd5163effe3b2cb910685a5956a00defc
>   Author: Steve Lawrence <slawrence@tresys.com>
>   Date:   Mon May 16 08:40:00 2011 -0400
> 
>       checkpolicy: wrap file names in filename trans with quotes
> 
> Then, recnetly, this patch was committed, which looks to be the same as
> the commit that was reverted:
> 
>   commit d72a9ec825ef2a8723510f62292cf2adfd4a2a6c
>   Author: Dan Walsh <dwalsh@redhat.com>
>   Date:   Tue Apr 12 09:54:46 2011 -0400
> 
>       checkpolicy: Redo filename/filesystem syntax to support filename
> trans rules
> 
> The comment for that commit said:
> 
> In order to support filenames, which might start with "." or
> filesystems that start with a number we need to rework the matching
> rules a little bit.  Since the new filename rule is so permissive it
> must be moved to the bottom of the matching list to not cover other
> definitions.
> 
> Both of those cases should have been supported by the "wrap in quotes"
> commit.
> 
> Was this just a mistake of something getting committed that shouldn't
> have been? Should d72a9ec825ef2a8723510f62292cf2adfd4a2a6c be reverted?

Yes, I will revert d72a9ec825ef2a8723510f62292cf2adfd4a2a6c as it should
not be there.

I don't, however, like how b42e15ffd5163effe3b2cb910685a5956a00defc was
done.  I don't like that the insert_id() code has some rather magic and
impossible to quickly glean the meaning of code to strip the ".  I'd
prefer if the " was an explicit part of the transition_def yacc
statement instead of it being stripped during insertion.  Doing such,
however, would require the portion of the bad patch that dedefined
FILENAME.  So it might not be worth it.  I'd also probably be happy(er)
if we did the stripping in define_filename_trans() with good comments
instead of it current cryptic form...

I'll probably attack this one of those ways down the line, but for now
I'll just revert the brokenness.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
