Subject: Re: patching 2.6.0-test1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: max barwell <maxb@paradise.net.nz>
Cc: SElinux list <SELinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1058497958.1735.11.camel@orac.lite.net.nz>
References: <1058497958.1735.11.camel@orac.lite.net.nz>
Content-Type: text/plain
Message-Id: <1058532327.1064.64.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 18 Jul 2003 08:45:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-07-17 at 23:12, max barwell wrote:
> I wanted to try out 2.6.0-test1, with selinux too of course.
> 
> I used the http://www.nsa.gov/selinux/lk/2.6.0-test1-selinux1.patch.gz
> patch, but when i booted and tried to relabel my system, an error said I
> was running a non selinux kernel.
> 
> Inspection of my dmesg does however say selinux initialised, but there
> are none of the usual messages about context labeling etc.
> 
> I noticed there are several patches in the
> http://www.nsa.gov/selinux/lk/ directory, do I only need the patch I
> mentioned above, or a combo, or do I need updated selinux files to
> handle a kernel this new.
> 
> I am using debian sid with Russel's selinux packages.

You can't use the 2.4-based SELinux policy and userland with the
2.5/6-based SELinux; the API has been completely overhauled, file
security labels have been migrated to using xattr (extended attributes),
etc.  You need the 2.5/6-based SELinux policy and userland as well as
the new kernel.  That is available from
http://www.nsa.gov/selinux/download5.html - you can use the policy and
userland components there with the 2.6.0-test1-selinux1 kernel; they are
still compatible despite the last full release being based on 2.5.74. 
However, since you are using Debian, you might want to try Colin
Walters' ports of the packages and patches.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
