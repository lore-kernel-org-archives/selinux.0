Date: Fri, 1 Sep 2006 14:52:01 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609011952.k81Jq1R2020324@faith.austin.ibm.com>
To: jbrindle@tresys.com, vyekkirala@TrustedCS.com
Subject: RE: ipsec and getpeercon()
Cc: latten@us.ibm.com, paul.moore@hp.com, sds@tycho.nsa.gov,
        selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I am thinking about this as well. Rather than use the Type specified in
> the SPD rule, we could use the one from the connecting domain. Should
> only be a minor change code-wise.
> 
> This way you could have just a set of domains that "polmatch"
> to a specific policy domain/Type, but they could all be using
> unique SAs based on the context of the connecting domain.
> 

I am not sure I understand. So for a particular traffic stream, the
Type(in regards to the security context) in the policy on the 
initiator is different than the Type in the policy on the receiver? 
And that both the initiator and receiver should send over their 
contexts and negotiate on which one to use?

Other than the policy, where would the receiving machine 
get its Type/domain from to send over for negotiating?  

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
