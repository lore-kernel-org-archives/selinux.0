MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Effect of changing SELinux package versions...
Date: Fri, 9 Nov 2007 13:59:50 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0420612B@de01exm68.ds.mot.com>
in-reply-to: <47349353.7080203@redhat.com>
References: <472B817D.3030400@redhat.com> <1194625539.624.57.camel@moss-spartans.epoch.ncsc.mil> <47349353.7080203@redhat.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Steve Grubb" <sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

The current customized version of Linux that I have comes with certain
versions of the SELinux libs/packages  (shown on the left column below).

Lets just say I am being forced to move to a newer version of Linux,
which will force me to move to the SELinux libs/packages shown below (on
the right column). 


1.  audit 1.0.14-1            audit 1.5.3
2.  libselinux 1.34.7         libselinux 2.0.13
3.  libsemanage 1.6.17-1      libsemanage 2.0.1
4.  libsepol 1.16.1           libsepol 2.0.3
5.  libsetrans 0.1.18         libsetrans 0.1.18
6.  mcstrans N/A              mcstrans 0.2.5
7.  policycoreutils 1.34.6    policycoreutils 2.0.16
8.  setools 3.0-2             setools 3.2-0


With the libs/package versions that I have on the left column, I am
moderately happy  :-)  Everything generally works the way I need them to
in "Permissive" mode.  The only problematic behavior I have seen is with
the Enforcing mode, where my Linux Card just resets after ~5 minutes for
no reason !

I was trying to evaluate any risks/surprises of upgrading to the
versions shown on the right. 

Would anyone be able to give me a risk/benefit/concern  assessment for
upgrading each of the libs/packages shown above. I am trying to
anticipate any problems I might have by going to the newer versions.

Thanks in advance,

- Rezaul.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
