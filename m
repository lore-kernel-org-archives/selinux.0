MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Where do I get a good Policy Base ?...
Date: Mon, 26 Oct 2009 21:16:34 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D077A087F@de01exm68.ds.mot.com>
In-Reply-To: <1256037508.4061.3.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com> <4AD9AD06.9030309@redhat.com> <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com> <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil> <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com> <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil> <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com> <1256037508.4061.3.camel@moss-pluto.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I used to have the following SELinux related package versions on my
Linux (2.6.18) system:

Checkpolicy      - 1.33.1
Libselinux       - 2.0.13
Libsemanage      - 2.0.1
Libsepol         - 2.0.3
Libsetrans       - 0.1.18
Policycoreutils  - 2.0.16

And I used a 'strict' Base policy from Fedora Core 6. Made the
modifications I needed on top of that, and I was very happy...


We get our OS packaged/delivered from a third party company, and we're
upgrading to Linux 2.6.27, and as part of this upgrade, we are also
migrating to much newer versions of the SELinux packages. They are:

checkpolicy-2.0.19 
libselinux-2.0.85 
libsemanage-2.0.33 
libsepol-2.0.37 
policycoreutils-2.0.69 
sepolgen-1.0.17 


My questions are:

1. I believe the "strict" policy is no longer supported in the above
versions of SELinux packages? Is this true ?

2. The entire set of policies that I have fine-tuned over the years
under my  /etc/selinux/strict/modules/active/modules/*.pp  directory in
my previous older system, can I make any use of that ?? In other words,
can that stuff be re-used at all ? Or do I need to develop policy from
scratch again ?

3. What will be a good base policy for me to start policy development on
? Will it be refpolicy, or should I grab the base 'targeted' policy from
fedora core 11 for example ?

4. Assuming 'strict' is no longer supported in the NEW package versions
above, and I use a base 'targeted' policy as my starting point... Should
I be able to simply remove the "unconfined.pp" policy module from the
base targeted policy, and that essentially turns my system into
"strict-like" mode ? Is that advisable ?

5. If I do continue to use the 'targeted' base policy as is, how can I
develop policy on top of that, to make sure I still block specific
things that I don't want to take place. For example, I DON'T want a
user_t to be able to write to files of type  etc_t  for example. How do
I go about accomplishing this  given the 'targeted' framework ? I know
how to do this in the old 'strict' framework, not sure how to go about
it with the targeted framework. Please shed some light or point me to
documents...

Again, Any references or documentation links would be greatly
appreciated.

Thanks in advance.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
