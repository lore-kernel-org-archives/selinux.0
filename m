Subject: Re: avc_* functions not in libselinux-python
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <cadfc0e40804081502j335cbc4au8d32d4d5fd956c8c@mail.gmail.com>
References: <cadfc0e40804081502j335cbc4au8d32d4d5fd956c8c@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 13:30:56 -0400
Message-Id: <1207762256.21223.489.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-08 at 17:02 -0500, Xavier Toth wrote:
> Can these functions get swig'd and their wrappers built into _selinux.so?

Patches accepted.

One possible issue here is function pointer callbacks, which is a more
general problem than just the avc interfaces in libselinux.  But if you
are ok with the default callbacks, I suppose there is no problem there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
