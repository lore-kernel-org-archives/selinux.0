From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@namei.org>
Subject: Re: MLS context?
Date: Sat, 22 Oct 2005 11:46:30 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>
References: <200510152027.59150.russell@coker.com.au> <200510211252.18124.russell@coker.com.au> <Pine.LNX.4.63.0510210011040.4922@excalibur.intercode>
In-Reply-To: <Pine.LNX.4.63.0510210011040.4922@excalibur.intercode>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510221146.40130.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 21 October 2005 14:13, James Morris <jmorris@namei.org> wrote:
> On Fri, 21 Oct 2005, Russell Coker wrote:
> > OK, it's a pity that we have the same character used for delimiting
> > fields within the identity:role:domain part and also for separating the
> > level and categories (with a possibility of two of them if we have
> > categories in both the low and high levels).
>
> It's probably not entirely too late at this stage to change this to
> something like:
>
> foo_u:foo_r:foo_t:s0+c0,c1-s1+c0,c1,c2

Given that we are going to have programs supporting regex matching of contexts 
we should probably avoid characters that have meaning in a regex.  So adding 
the use of a '+' is probably a bad idea on that count (and removing the use 
of '.' might be a good idea if we are going to make changes).  Also having 
'-' and '+' in the same context is probably going to confuse some people.

It seems that the available non-regex characters are "-:=,;_~|{}%#@!&", the 
ones that can be used without danger are "-:=,_~{}%#@".  The current uses for 
':' to separate the DT fields '-' for the range, and ',' for multiple single 
categories are good.  That leaves "=_~{}%#@".

foo_u:foo_r:foo_t:s0:c0,c1-s1:c0,c1.c2

How about replacing the above with:

foo_u:foo_r:foo_t:s0#c0,c1-s1#c0,c1%c2

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
