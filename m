Subject: Re: Changing context with UID - doubt
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bartlomiej Balcerek <Bartlomiej.Balcerek@pwr.wroc.pl>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.44.0501091400340.4757-100000@sun1000.pwr.wroc.pl>
References: <Pine.GSO.4.44.0501091400340.4757-100000@sun1000.pwr.wroc.pl>
Content-Type: text/plain
Message-Id: <1105456164.20566.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 11 Jan 2005 10:09:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-01-09 at 08:37, Bartlomiej Balcerek wrote:
> Hello,
> I'am still newbie in SELinux. I'am confused, if SELinux can
> automaticaly change process context when changing system EUID ?
> My process executes shell with different EUID, which just executes another
> subprocess. I want that subprocess to run in role or domain coupled
> with its EUID, defined in "user" file. It is possible in SELinux ?

No, SELinux has its own user identity attribute, and does not use the
Linux uids for its own access control or transition decisions (although
the existing Linux DAC checks are still applied as well).  See the User
Identity Model section of
http://www.nsa.gov/selinux/papers/policy2/x87.html.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
