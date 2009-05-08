Date: Fri, 8 May 2009 09:17:55 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        viro@ZenIV.linux.org.uk, Jamie Lokier <jamie@shareable.org>
Subject: Re: SELinux and access(2), we want to know.
Message-ID: <20090508141755.GB19721@us.ibm.com>
References: <1241723924.2791.107.camel@localhost.localdomain> <20090507195729.GA21104@us.ibm.com> <4A03AC41.1040505@schaufler-ca.com> <1241785627.6452.193.camel@localhost.localdomain> <4A0429A7.7060507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A0429A7.7060507@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Daniel J Walsh (dwalsh@redhat.com):
> Totally useless and gives the SELinux SUCKS crowd more ammunition. If  
> the MLS people want to treat ACCESS==OPEN then we are going to have a  
> big boolean/tunable flag for their paranoia.  For everyone else.  Lets  
> try to figure out when an application is actually doing something evil.

I'm really not here to be difficult, but if you believe that a failed
open is a problem bc an attacker can poke around the fs, and you believe
that nautilus can be hacked, then ignoring access just doesn't make
sense.  The fact that users are being inconvenienced doesn't change
that.

Jamie's point (obscured in code because it is implemented through
the use of fsuid) that for DAC purposes access and open use different
creds, is useful.  I can buy that audit should spit out a slightly
different message to show that MAC failed on real cred attempt
instead of subj...  (Even though the values of uid, euid, and fsuid
in the audit msg should make that clear).

So in that case, given how the code is structured currently in
fs/{open,namei}.c and through inode_permission, an extra flag
which selinux simply uses to judge which audit msg (if any) to
spit out seems the simplest way to do it.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
