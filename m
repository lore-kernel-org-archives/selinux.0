Subject: RE: [PATCH] checkpolicy - nodecon ordering
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <36282A1733C57546BE392885C06185924D91E3@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185924D91E3@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1099402235.31739.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 08:30:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 16:58, Chad Hanson wrote:
> I could be missing something here, but I can't think of a valid case where
> your statement above is true. A mask with more bits always has a greater
> integer value than a mask with less bits.

Hi,

My mistake.  I was thinking that classless addressing might pose a
problem here, but was incorrect.  Comment retracted.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
