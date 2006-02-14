Subject: Re: [SEMANAGE/utility] Improve usage()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <43F1B708.3030205@cornell.edu>
References: <43F1B708.3030205@cornell.edu>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 11:08:55 -0500
Message-Id: <1139933335.14253.250.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-14 at 05:55 -0500, Ivan Gyurdiev wrote:
> Maybe it's just me, but the semanage usage() is still not making sense...
> Please apply if you consider this an improvement.
> 
> 1) Document arguments to -ftype
> 2) Give example of a list of multiple roles (space separated, quoted)
> 3) Specify which protocols are allowed for ports
> 4) Abandon alphabetical ordering for more logical ordering.
> Specifically, group primary options (-a/d/m/l) together, and then have a 
> section for object-specific options below.

Yes, I agree that this is clearer.  Need to modify the man page in the
same manner, I think.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
