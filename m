Subject: Re: policy hierarchy patch
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <4251BA1E.9040406@trustedcs.com>
References: <1112631282.19526.18.camel@localhost>
	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>
	 <1112643447.19527.30.camel@localhost>  <4251BA1E.9040406@trustedcs.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 10:03:02 -0400
Message-Id: <1112709782.19531.39.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Sounds good to me.  I should actually be able to take a look at it tomorrow and 
> help you out with the code.  I know that the parsing isn't the prettiest...  I 
> think I may be able to make it look better in C code.  And we didn't really like 
> the spaces anyway.
> 

So what were you thinking? the hierarchy stuff already has the
infrastructure for checking for '.' in the identifier and splitting out
the "parent", which in your case would be the lower part of the range.
Obviously these have hierarchy specific names and would be very
confusing to on-lookers so maybe we could generalize those to avoid
repeating code. 

Then we just convert everything to identifier and anything that expects
a category can check for '.' and set the values appropriately, this
seems even cleaner than the way it's done now with the MLS_CAT_RANGE
string.. 

I can probably bang this out pretty quickly unless you had something
else you wanted to do with MLS or prefer to deal with that part
yourself, let me know what you want to do. Also, will you be able to
send a policy patch at the same time that rids the policy of those
spaces?

Thanks, Joshua Brindle


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
