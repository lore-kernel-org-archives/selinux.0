Date: Thu, 22 Jan 2015 16:51:50 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Add security hooks to binder and implement the hooks for
 SELinux.
Message-ID: <20150122085150.GB1268@kroah.com>
References: <1421855650-22522-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421855650-22522-1-git-send-email-sds@tycho.nsa.gov>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 arve@android.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jan 21, 2015 at 10:54:10AM -0500, Stephen Smalley wrote:
> Add security hooks to the binder and implement the hooks for SELinux.
> The security hooks enable security modules such as SELinux to implement
> controls over binder IPC.  The security hooks include support for
> controlling what process can become the binder context manager
> (binder_set_context_mgr), controlling the ability of a process
> to invoke a binder transaction/IPC to another process (binder_transaction),
> controlling the ability of a process to transfer a binder reference to
> another process (binder_transfer_binder), and controlling the ability
> of a process to transfer an open file to another process (binder_transfer_file).
> 
> These hooks have been included in the Android kernel trees since Android 4.3.

Very interesting, I missed the fact that these were added in that tree,
thanks for digging it out and submitting it.

I'd like some acks from some Android developers before I take these.
Or, if it's easier for them to go through the security tree, that's fine
with me as well.

thanks,

greg k-h
