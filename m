From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Subject: Re: MCS read only cats
Date: Thu, 12 Nov 2009 22:13:43 +1100
Cc: SELinux@tycho.nsa.gov
References: <C72056E1.AFD7E%csellers@tresys.com> <200911121413.31687.russell@coker.com.au> <20091112075857.GO28630@myhost.felk.cvut.cz>
In-Reply-To: <20091112075857.GO28630@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200911122213.49287.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Nov 2009, Michal Svoboda <michal.svoboda@agents.felk.cvut.cz> 
wrote:
> Russell Coker wrote:
> > Currently we don't support ranges on files, but we can change policy
> > to allow it.  You could have something like the following:
> >
> > mlsconstrain file { read }
> >         (( h1 dom l2 ) or ( t2 == domain ) or ( t1 == mlsfileread ));
> >
> > mlsconstrain file { create relabelto }
> >         (( h1 dom h2 ) and ( l1 dom l2 ));
>
> thanks for the tip. Actually I had the same idea yesterday! Only that I
> thought of
>
> mlsconstrain file { create relabelto }
>          (( h1 dom h2 ) and ( h1 dom l2 ));
> 	                      ^
>
> because in my MCS schema users usually have low = s0.

That will work too.  Lots of things will work, you just have to decide which 
is most appropriate given your security goals.  If anyone has given much 
thought to implementing read-only files with MCS they don't seem to have 
written about it publicly, so this is all new.

> What exactly do you mean by not supporting ranges on files? Normally MCS
> has a constrain on create/relabelto such as h2 eq l2, but I think if the
> constrain is relaxed in the abovementioned fashion then there would be
> no other problems? (I have seen multiranged files in the MLS policy...)

Yes, it's an arbitrary constraint.  Most people think that MCS is complex 
enough without ranged files.

> > But generally read-only files are implemented with new types.  I do
> > that on the custom policy for my SE Linux Play Machine.
>
> Well, what I want is to give users one login that maps to a generic
> identity (say, user_u), but control their access to file of various
> projects via MCS categories.

That is pretty common, but not with read-only vs read-write restrictions.

> Now, if I had read only and read/write TE rules, I can imagine giving
> every user 2 accounts, of which one would result in a shell that is
> confined to read only operations, but has more MCS cats, but I can't
> imagine how would I accomplish that with one account.

One Unix UID can have multiple SE Linux contexts.  The mapping of Unix account 
name to UID doesn't have to be 1:1.  But if you have multiple Unix accounts 
with the same UID then tools start to break.

Another possibility to consider is to give some file types an exclusion for 
read checks in the constraints.  That would mean that anyone could read them 
if the TE rules permit but MCS levels constrain write access.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
