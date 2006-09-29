Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TIZ5Cq031125
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 14:35:05 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TIYVu8001180
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 18:34:31 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Subject: Re: [PATCH 1/1] NetLabel: add audit support for configuration changes
Date: Fri, 29 Sep 2006 14:35:53 -0400
Cc: linux-audit@redhat.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov
References: <20060928180326.896170000@hp.com> <200609291008.07290.sgrubb@redhat.com> <451D614F.8090502@hp.com>
In-Reply-To: <451D614F.8090502@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609291435.53680.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 29 September 2006 14:09, Paul Moore wrote:
> > type field is already taken for another purpose, it needs to be renamed.
>
> If we can't have duplicate field names I would propose prefixing both
> these fields (and doing similar things with the other NetLabel specific
> fields) with a "cipso_" making them "cipso_doi" and "cipso_type".

That would be fine. This limits future field name collisions.

> >>+/**
> >>+ * netlbl_unlabel_acceptflg_set - Set the unlabeled accept flag
> >>+ * @value: desired value
> >>+ * @audit_secid: the LSM secid to use in the audit message
> >>+ *
> >>+ * Description:
> >>+ * Set the value of the unlabeled accept flag to @value.
> >>+ *
> >>+ */
> >>+static void netlbl_unlabel_acceptflg_set(u8 value, u32 audit_secid)
> >>+{
> >>+     atomic_set(&netlabel_unlabel_accept_flg, value);
> >>+     netlbl_audit_nomsg((value ?
> >>+                         AUDIT_MAC_UNLBL_ACCEPT : AUDIT_MAC_UNLBL_DENY),
> >>+                        audit_secid);
> >
> > Looking at how this is being used, I think only 1 message type should be
> > used. There are places in the audit system where we set a flag to 1 or 0,
> > but only have 1 message type. We record the old and new value. So, you'd
> > need to pass that to the logger.
>
> With that in mind I would probably change the message type to
> AUDIT_MAC_UNLBL_ALLOW and use a "unlbl_accept" field; is that okay?  

That would be fine. Just a quick note...we have generally been "old " to 
indicate the previous value. Example, "backlog=512 old=256".

> >>+/**
> >>+ * netlbl_audit_start_common - Start an audit message
> >>+ * @type: audit message type
> >>+ * @secid: LSM context ID
> >>+ *
> >>+ * Description:
> >>+ * Start an audit message using the type specified in @type and fill the
> >>audit + * message with some fields common to all NetLabel audit messages.
> >>Returns + * a pointer to the audit buffer on success, NULL on failure.
> >>+ *
> >>+ */
> >>+struct audit_buffer *netlbl_audit_start_common(int type, u32 secid)
> >>+{
> >
> > Generally, logging functions are moved into auditsc.c where the context
> > and other functions are defined.
>
> How about leaving this for a future revision?

Come to think of it, you don't need to move it. The reason to move it is to 
access the context and use helper functions related to it. But I found that 
you were using "current" which may not always be the sender. So if you cannot 
use current, most of the stuff you are logging can't be, so the event being 
logged becomes simpler and you don't need to move it.

I have not traced through all the code, but if you do any security checks 
before taking the rules, be careful not to use current.

> >>+     audit_log_format(audit_buf,
> >>+                      "netlabel: auid=%u uid=%u tty=%s pid=%d",
> >>+                      audit_loginuid,
> >>+                      current->uid,
> >>+                      audit_tty,
> >>+                      current->pid);
> >
> > Why are you logging all this? When we add audit rules, all that we log is
> > the auid, and subj. If we need to log all this, we should probably have a
> > helper function that gets called by other config change loggers.
>
> If I drop the uid, tty, and pid fields will this be acceptable?

 and comm & exe, yes. Anything you were basing off of current has to go. The 
audit rule logging was reduced to the credentials that are carried along in 
the netlink packet since that's all you can trust. The sending process could 
be gone by the time you get to this point in the code.

> >>+     audit_log_format(audit_buf, " comm=");
> >>+     audit_log_untrustedstring(audit_buf, audit_comm);
> >>+     if (current->mm) {
> >>+             down_read(&current->mm->mmap_sem);
> >>+             vma = current->mm->mmap;
> >>+             while (vma) {
> >>+                     if ((vma->vm_flags & VM_EXECUTABLE) &&
> >>+                         vma->vm_file) {
> >>+                             audit_log_d_path(audit_buf,
> >>+                                              " exe=",
> >>+                                              vma->vm_file->f_dentry,
> >>+                                              vma->vm_file->f_vfsmnt);
> >>+                             break;
> >>+                     }
> >>+                     vma = vma->vm_next;
> >>+             }
> >>+             up_read(&current->mm->mmap_sem);
> >>+     }
> >>+
> >
> > If this function was moved inside auditsc.c you could use a function
> > there that does this. But the question remains why all this data?
>
> In the ideal world would you prefer this to be removed?

Yes.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
