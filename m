Subject: Re: /selinux/create + X windows = performance limiter
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, ewalsh@tycho.nsa.gov, ajax@redhat.com
In-Reply-To: <1235597640.25352.31.camel@localhost.localdomain>
References: <1235595005.25352.29.camel@localhost.localdomain>
	 <1235596469.8900.4.camel@localhost.localdomain>
	 <1235597640.25352.31.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 26 Feb 2009 10:49:57 -0500
Message-Id: <1235663397.13059.145.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-02-25 at 16:34 -0500, Eric Paris wrote:
> On Wed, 2009-02-25 at 16:14 -0500, Stephen Smalley wrote:
> > On Wed, 2009-02-25 at 15:50 -0500, Eric Paris wrote:
> > > So the X people here at Red Hat complained the other day that they have
> > > to do an open, write, read, close very very often on /selinux/create.
> > > They'd like to cut the number of syscalls down.  Even if the open and
> > > close are fast, they are still syscalls that still take time and still
> > > provide maximum limits on the operations per second they can do.  (I
> > > think ajax said he was estimating it at 10000/sec, but I don't remember
> > > the math or even if it was reasonable)
> > > 
> > > We've got 2 choices.  We could reduce the number of syscalls to 3 by
> > > adding another operation, maybe an ioctl, that would reset the
> > > transaction.  X could keep the file open indeffinitely and instead use
> > > an open, write, read, ioctl, write read, ioctl, etc callpath.
> > > 
> > > We could also reduce the number of syscalls needed to 2. We could just
> > > say that after a full read we reset the transaction.  So the process
> > > would look like open, write, read, write, read, write, read, etc....
> > > 
> > > Does anyone see a problem with going to the 2 syscall kernel interface?
> > > Userspace which uses the library shouldn't even notice since the library
> > > (I believe) takes care of the open, write, read, close chain and would
> > > continue to work properly.
> > > 
> > > If the X people can really show that this call chain makes a big
> > > performance difference I'm sure we could come up with other ways to
> > > speed things up (crazy things that sds would hate like exposing internal
> > > sids to userspace and passing those back and forth across a new boundary
> > > for fast in kernel operations.  But for now, just stopping opening and
> > > closing a file 1000s of times a second seems like an easy, obvious, and
> > > reasonable win.
> > 
> > Wouldn't it be simpler and more efficient to just start caching the
> > results of security_compute_create in the AVC so that
> > avc_compute_create() will get most answers from the cache, just like
> > avc_has_perm()?
> 
> I like how you respond to my "future work" part first  :)   I'll take a
> look at caching these results but before I put much into what I can't
> clearly say would be a win, I'm going to have to get some read perf data
> showing where in selinux code we are spending time....

I think you'll get the biggest win from having the userspace AVC cache
the compute_create results.  Shouldn't be hard.

> > BTW, as I recall, the transaction ops don't actually require a separate
> > write() + read() pair; they can be combined into a single call that does
> > both request + response transfer.
> 
> What syscall would we use to send the info pack and forth?  don't say
> ioctl, don't say ioctl, don't say ioctl......

No, just read().  Something along these lines would allow a single
read() call to both submit the request and collect the response, as long
as the buffer is large enough for both.

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 01ec6d2..9a5d2a8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -544,9 +544,20 @@ static ssize_t selinux_transaction_write(struct file *file, const char __user *b
 	return rv;
 }
 
+static ssize_t selinux_transaction_read(struct file *file, char __user *buf, size_t size, loff_t *pos)
+{
+	if (!file->private_data) {
+		ssize_t rv = selinux_transaction_write(file, buf, size, pos);
+		if (rv < 0)
+			return rv;
+	}
+	return simple_transaction_read(file, buf, size, pos);
+
+}
+
 static const struct file_operations transaction_ops = {
 	.write		= selinux_transaction_write,
-	.read		= simple_transaction_read,
+	.read		= selinux_transaction_read,
 	.release	= simple_transaction_release,
 };

Some might object to this however on the grounds that read(2) isn't
supposed to do anything with the initial contents of buf.

nfsctl does something similar to allow a read() without a prior write()
to get status information but it only does a 0-byte write so it isn't
actually using the buffer contents.

I'm not sure though that we'd gain much in performance from this.
Eliminating the need for open/close on each transaction is likely to be
more significant as you say.  I'd start with the userspace AVC though
because that offers the best situation - no need for any syscalls when
the result has previously been computed.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
