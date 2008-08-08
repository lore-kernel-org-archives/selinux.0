Message-ID: <489C6852.7060501@redhat.com>
Date: Fri, 08 Aug 2008 11:37:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Why is customizing labeling and seusers so SLOOOOOOOWWWWW.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is it time to move seuser and local file context labeling out of
libsemanage?  I have just heard from the virt team that they want to
modify the context of a virt machine at creation time, so they have
looked at chcon -t virt_image_t.  They understand that changing the
image will not survive a relabel but

"Unfortunately, semanage is rather slow application to run. It also
pulls in the entire python runtime, which isn't something we can do in
libvirt. We really need some light-weight way of adding new file
contexts to the policy persistently."

I explained they can call libsemanage via "C"  but the comment brings up
a point of why does semanage recompile policy when changing file context
or the seusers file.  All we really need to do is verify the contests
are correct and this should be a very fast operation.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
