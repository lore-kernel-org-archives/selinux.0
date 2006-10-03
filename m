Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93LHMHp026674
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 17:17:22 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93LGlGw014949
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 21:16:48 GMT
Message-ID: <4522D361.3030008@hp.com>
Date: Tue, 03 Oct 2006 17:17:21 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: Re: Labeled networking at the end of the day Oct 2, 2006
References: <1159908799.10614.22.camel@localhost.localdomain>
In-Reply-To: <1159908799.10614.22.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------030209000300050309000103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030209000300050309000103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Eric Paris wrote:
> Where do we stand with labeled networking today?
> 
> I published a kernel yesterday which is sorta close to having what we
> need for labeled networking.  This kernel includes 3 patch sets.
> 
> 1) netlabel changes to audit configuration changes
> 2) secid reconciliation patch set (9 patches) for secmark/ipsec
> 3) secid reconciliation patch to include netlabel
> 
> to even be close to a usable kernel we still need
> 
> 1) fix for packets intended for ipsec tunnels to not be clear text.
> Venkat indicated he had his own way he wanted to solve this problem on
> Monday but I did not see any updates today.  This is a major problem
> which must get fixed somehow, soon.
> 2) ipsec configuration auditing.  if we can do this in policy all the
> better.  if not, I need a patch.
> 3) fix for netlabel caching race which can cause an opps.  Can be worked
> around by using a sysctl (see the e-mail from paul moore)
> 4) fix for netlabel correctness in the same e-mail from paul he
> mentioned correctness issues in -v3 inside selinux-ip-postroute-last

Updates from the NetLabel side of the house:

I have patches for both #3 and #4 sitting on my disk.  I've got a kernel
(based on the source RPMs you posted this morning) building right now
with the patch for #3, it should be done pretty soon.  I want to let it
run overnight and if everything looks okay I'll post it to the lists.

The fix for patch #4 is probably just going to be a respin, i.e. "v4" of
the NetLabel secid reconciliation patch as I don't think the "v3"
version of the patch has made it into a tree yet (net-2.6 seems to be
missing?).  For those who are curious attached is a diff between the
"v3" and upcoming "v4" patch.  I'll post this once I have pushed out the
patch for #3 and have had time to test this.

-- 
paul moore
linux security @ hp

--------------030209000300050309000103
Content-Type: text/x-patch;
 name="secid_netlabel_v3-v4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="secid_netlabel_v3-v4.diff"

diff -u net-2.6/security/selinux/hooks.c net-2.6/security/selinux/hooks.c
--- net-2.6/security/selinux/hooks.c
+++ net-2.6/security/selinux/hooks.c
@@ -3750,22 +3750,23 @@
 		return 1;
 
 	if (!skb->secmark) {
+		struct sk_security_struct *sksec = skb->sk->sk_security;
 		u32 xfrm_sid;
 		u32 nlbl_sid;
 
-		err = selinux_netlbl_skb_sid(skb, skb->secmark, &nlbl_sid);
+		selinux_skb_xfrm_sid(skb, &xfrm_sid);
+		err = selinux_netlbl_skb_sid(skb,
+					     xfrm_sid ? xfrm_sid : sksec->sid,
+					     &nlbl_sid);
 		if (err)
 			goto out;
-		selinux_skb_xfrm_sid(skb, &xfrm_sid);
 
 		if (nlbl_sid)
 			skb->secmark = nlbl_sid;
 		else if (xfrm_sid)
 			skb->secmark = xfrm_sid;
-		else if (skb->sk) {
-			struct sk_security_struct *sksec = skb->sk->sk_security;
+		else if (skb->sk)
 			skb->secmark = sksec->sid;
-		}
 	}
 
 	err = avc_has_perm(skb->secmark, nf_secid, SECCLASS_PACKET,
@@ -3920,25 +3921,24 @@
 						       family, addrp, len);
 	else {
 		if (!skb->secmark) {
+			struct sk_security_struct *sksec =
+				skb->sk->sk_security;
 			u32 xfrm_sid;
 			u32 nlbl_sid;
 
+			selinux_skb_xfrm_sid(skb, &xfrm_sid);
 			err = selinux_netlbl_skb_sid(skb,
-						     skb->secmark,
-						     &nlbl_sid);
+					      xfrm_sid ? xfrm_sid : sksec->sid,
+					      &nlbl_sid);
 			if (err)
 				goto out;
-			selinux_skb_xfrm_sid(skb, &xfrm_sid);
 
 			if (nlbl_sid)
 				skb->secmark = nlbl_sid;
 			else if (xfrm_sid)
 				skb->secmark = xfrm_sid;
-			else if (skb->sk) {
-				struct sk_security_struct *sksec =
-						skb->sk->sk_security;
+			else if (skb->sk)
 				skb->secmark = sksec->sid;
-			}
 		}
 		err = avc_has_perm(skb->secmark, SECINITSID_UNLABELED,
 				   SECCLASS_PACKET, PACKET__FLOW_OUT, &ad);

--------------030209000300050309000103--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
