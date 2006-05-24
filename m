Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4OIF24r014394
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 14:15:02 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4OIF2bH028514
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 18:15:02 GMT
Subject: Re: [PATCH] policy server API
From: Christopher Ashworth <cashworth@tresys.com>
To: selinux@tycho.nsa.gov
Cc: selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1148417141.20016.53.camel@popeye.columbia.tresys.com>
References: <1148417141.20016.53.camel@popeye.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 14:15:01 -0400
Message-Id: <1148494501.517.76.camel@popeye.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hmmm.  In this patch, I included the following "destroy" implementation:


+/* Callback that allows us to do cleanup on destroy.
+ * In our case, we will do a sanity check on the 
+ * file descriptor, and close the connection if it
+ * wasn't already closed (for example due to an earlier
+ * error that caused the client to skip a call to
+ * semanage_ps_disconnect).
+ */
+void semanage_ps_destroy(semanage_handle_t *sh)
+{
+       if (sh && (sh->u.ps_handle.socket_fd > 0)) {
+               semanage_ps_disconnect(sh);
+       }
+}


This was spurred in general by the reasoning given in the comment, and
specifically by the fact that the proposed error case is exactly the way
at least one client application behaves (setsebool).

However, I was just looking at libsemanage/include/semanage/handle.h,
and saw the following comment:

/* Deallocate all space associated with a semanage_handle_t, including
 * the pointer itself.  CAUTION: this function does not disconnect
 * from the backend; be sure that a semanage_disconnect() was previously
 * called if the handle was connected. */
void semanage_handle_destroy(semanage_handle_t *);


So my sanity check is counter to the intended design and this operation
should be turned into a no-op, as it is in direct_api.c. 

I'm a little confused by this design, however, because it is asymmetric.
Namely, there is a callback to a custom destroy function in
semanage_handle_destroy, but no such callback to a corresponding create
function in semanage_handle_create.  This appears to leave the
semanage_direct_destroy and semanage_ps_destroy functions without a
mate.  Presumably, since the callbacks are set in the semanage_*_connect
functions, the destroy callbacks are potentially cleaning up stuff that
is allocated during connect.  A little odd, since it seems like it would
be expected to be cleaned up in the corresponding disconnect function.

At any rate, the following modifications need to be made

- turn semanage_ps_destroy in this patch into a no-op
- submit a separate patch to fix setsebool


I'll resubmit the patch after awhile to give a chance for more comments
and corrections.

Christopher


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
