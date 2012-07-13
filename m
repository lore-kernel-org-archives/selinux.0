Message-ID: <1342180996.7054.7.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Add two device-specific labelings to target CSR GPS Chips.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hqjiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Fri, 13 Jul 2012 08:03:16 -0400
In-Reply-To: <1342132671-17376-1-git-send-email-hqjiang1988@gmail.com>
References: <1342132671-17376-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-12 at 15:37 -0700, hqjiang wrote:
> Hi, all
> 
> Today AOSP has updated the patches of targeting denies of GpsLocationManager.

Clarification: We merged those patches into our tree, but AOSP has not
yet refreshed from our tree (at least as far as I can tell).

> But the correspoinding labeling parts are not updated in device-specific sepolicy. 
> We submit the labels to complement the functions. 

I applied the first patch already on our seandroid branch, and have now
cherry-picked it to seandroid-4.0.4 and seandroid-4.1.1.  You need to
specify what branch(es) you want your patches applied.

> If you update the patches from William Robert, you can find that the genfscon syntax
> finally can be simply achieved in sepolicy.fc which is device-specific.

I don't understand this, as the patches I have from him require genfscon
entries to go into sepolicy.genfs_contexts, not sepolicy.fc, and putting
them into a .fc file will not get them merged into the kernel policy.
The file contexts configuration (file_contexts and *.fc) files are not
part of the kernel policy; they are only used by userspace components
like init, ueventd, restorecon, etc.  Even if he has new patches that
allow you to mingle them in sepolicy.fc, I don't like that approach.  If
you want to create a single sepolicy.oc (ocontexts) file and split it as
part of the build process, I can support that.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
