From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Debian SE Linux status
Date: Sat, 29 Mar 2008 12:30:18 +1100
Cc: jwcart2@epoch.ncsc.mil, Joshua Brindle <method@manicmethod.com>,
        SE-Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>
References: <200803281106.47699.russell@coker.com.au> <1206714753.29088.35.camel@moss-lions.epoch.ncsc.mil> <1206717541.3302.492.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206717541.3302.492.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803291230.23311.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 29 March 2008 02:19, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> That was a technology transition for SELinux, one that all the
> distributions went through.  All the distributions now use modular,
> managed policy by default, and monolithic policy support remains for
> legacy systems (e.g. RHEL4) and possibly for embedded systems since
> modular, managed policy presently has a real cost to it (unlike the MLS
> support).

Nowadays it seems that a very common case of development for embedded systems 
(probably the most common case) is to use some sort of bigger system to do 
the development and then deploy on the small system.  An example of this is 
the Familiar developers who built iPaQ machines with hard drives...

Given the use of such a bigger system, which could even have a different CPU - 
AFAIK there are no CPU specific requirements in the policy build (or if they 
are then it's a bug) you could have a modular managed policy development 
process that results in copying the policy.N file to the destination machine.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
