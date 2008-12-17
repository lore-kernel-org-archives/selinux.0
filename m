MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Avc denies while running in Permissive mode...
Date: Wed, 17 Dec 2008 12:08:18 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D051775A7@de01exm68.ds.mot.com>
In-Reply-To: <1228916038.23307.1.camel@localhost.localdomain>
References: <1228865476.3737.13.camel@localhost.localdomain> <1228916038.23307.1.camel@localhost.localdomain>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

Lets just say in my product, we are not confident enough to run in
Enforcing mode just yet !

I used Fedora Core 7 *strict* policy as my base policy, and built my own
additional myModule.pp policies on top of that. So, I have *strict*
SELinux policy running on an embedded Linux Card, in Permissive mode.

Due to auto-relabelling of the filesystem, files in the  /etc/
directory get appropriately labelled as  etc_t (as desired).

I have myModule.pp policy lines that say :

neverallow user_t etc_t:file write;
neverallow user_t etc_t:dir write;

My question is:

When I ssh in as a test user with a security context =
[user_u:user_r:user_t], and I attempt to modify/write some file in the
/etc/  directory,  I do get an avc deny message in the audit.log file,
as desired  :-)

But subsequent attempts to do the same thing doesn't generate any more
avc denies ??? In other words, when I attempt to modify the same file
again, or modify a different file under /etc/  as the same test user...
I DON'T get any more avc deny messages ?!?

I know that if I switch from Permissive to Enforcing mode, I get avc
deny msgs for EVERY single violation !

But in Permissive mode, I would like to also get a deny for every
violation attempt.. How do I achieve this ?

Because I am running with *strict* policy, during normal operation of my
Linux card, I have numerous avc deny messages that pop up from time to
time. So I collect all those deny messages, run audit2allow on them, and
try to eliminate these denies in the policy.  

But what confuses me is that, there are some avc denies that seem to be
about the same operation, and those avc denies keep popping up
repeatedly in the Permissive mode... Why then cant the scenario
described above produce repeated avc denies ???

I understand that there is a mechanism to prevent flooding of avc denies
in Permissive mode. And I did try to change the
/selinux/avc/cache_threshold file, by putting a "1" there instead of
"512". But doing that causes a lot of CPU to be chewed up by SELinux.   

Any other suggestions for why the scenario I described above, about a
test user (user_t), trying to modify multiple files under the /etc/
directory creates only one avc deny message, and doesn't generate an avc
deny for each attempt ???

Apologize for the long mail. Thanks in advance for your help,

- Rezaul.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
