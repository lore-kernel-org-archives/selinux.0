Date: Sat, 23 May 2015 08:11:58 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: william.c.roberts@intel.com
Subject: Re: [RFC] [PATCH] kernfs: hook inode initialization for LSMs
Message-ID: <20150523151158.GC11783@kroah.com>
References: <1432319136-160378-1-git-send-email-william.c.roberts@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432319136-160378-1-git-send-email-william.c.roberts@intel.com>
Cc: linux-security-module@vger.kernel.org, sds@tycho.nsa.gov,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 22, 2015 at 11:25:35AM -0700, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> On the Android side of the house, were required to label each and
> every sysfs file with a specific label.

"required"?

And what label are you having to use?

> sysfs often has transient
> files, and this uncovered a limitation in SELinux. In most filesystems
> the new inode inherits from the parents label, but in sysfs, this
> was not the case. The new inode would inherit the syfs wide "default"
> label.

Do you really want to build up a list of SELinux policies for sysfs
files/directories, only to see them need to be redone when the tree
moves things around in the future?

What type of "rules" are you using here for sysfs to handle the
dynamic-ness of the tree properly?

thanks,

greg k-h
