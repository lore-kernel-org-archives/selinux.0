From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: [RFC] [PATCH 4/4] SELinux changes
Date: Thu, 20 Sep 2007 11:31:50 -0400
Cc: "'James Morris'" <jmorris@namei.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <method@manicmethod.com>
References: <009901c7fb94$7930ee90$cc0a010a@tcssec.com>
In-Reply-To: <009901c7fb94$7930ee90$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709201131.50680.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, September 20 2007 10:42:29 am Venkatesh Yekkirala wrote:
> I know we wanted to hash out the flow control stuff first which I believe
> we have a good handle on at this point. So my above query.

I know you guys are very anxious to get this done, I appreciate that, but I'm 
not to the point where I consider the flow control bits sorted quite yet.  
You've done a great job with the patches and we are definitely moving forward 
but I think we still have a ways to go.

FWIW, my main concern right now is sorting out a way to get this all upstream 
in a manner which doesn't break anything and doesn't totally screw 
performance.  Until we can address these issues all of the new functionality 
is a no-go.  I'll send out more info later, but right now this is the list of 
items we need in descending priority:

 1.  SELinux functionality counter/flag
     (similar to compat_net but useable for more than just networking and
      the value would be a "version" not simply a boolean on/off)
 2a. Reconcile NetLabel and labeled IPsec labels into a single, unified peer
     label with a single avc_has_perm() call for each check, create new
     peer object class/permissions
 2b. Introduce runtime activation of new peer access checks
     (to solve James performance concerns - when no labeled networking
      configuration is present do not perform any peer label access checks)
 3.  Flow control hooks
 ?*.  Fallback peer labels
 ?*.  Loopback peer labels

 * the order of the last two probably isn't important

My current plan is to create a new labeled networking git tree where we can 
slowly collect all of these patches in one place for testing and when we are 
happy I'll push the whole mess up to James/Dave/etc.  

[Okay, I just created the repo but it's currently just an empty clone of
 Linus' tree] 
 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

Now, that doesn't mean I'm going to make you wait on the flow control patches 
(we _are_ getting close here), I'll go ahead and merge them in to the testing 
tree so they are available while I work on the items #1 and #2.  I think once 
we get items #1 through #3 done and tested we can probably push those 
upstream for comment/review.

I'll get you some comments on your latest flow control patchset before the end 
of the week - I promise.

> No problem. I also wanted to ping on any further thinking on using
> the IP option space (versus split secmark) for carrying the loopback
> label as well as the label when a forwarded packet has used NetLabel/cipso
> when coming in, but is going out using a non-labeled (plain) IPsec tunnel.
> In the latter case, we would have the label unavailable for use in
> the outgoing filter checks unless the ip option in the inner "tunneled"
> packet is copied into the outer "tunnel" packet as well. I suggested
> using the special localhost IP option to carry this label, but stripping
> it out right after the flow_out checks. But on further discussions here
> on our end, it seems like this would be extremely fragile, even if made
> somehow workable in all cases. For example, this could potentially fail
> when using AH on the tunnel packet. Which all makes us believe going
> the split secmark route might be the most reliable/robust route under
> the circumstances.

Okay, let's see.  Like I said, I'm a little preoccupied with items #1 and #2 
right now, but you make a valid point.  Just to be clear, I consider 
splitting the secmark field to be a last resort option and while I'm not 
giving a NO vote on it, I want to make sure we have examined all of the other 
possibilities before going down that road.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
