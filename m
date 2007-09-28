Message-ID: <46FD1AAE.9060905@redhat.com>
Date: Fri, 28 Sep 2007 11:15:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [patch 0/4] libsemanage: genhomedircon regressions
References: <20070927200712.950671948@tresys.com> <1190986603.22078.1.camel@moss-spartans.epoch.ncsc.mil> <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B01588010FFB75@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588010FFB75@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Todd Miller wrote:
> Stephen Smalley wrote:
>> Looking again at the output, the order differs - the libsemanage
>> genhomedircon puts the specific user entries first and then the
>> generic /home entries, which seems wrong given that later entries take
>> precedence for matchpathcon.  genhomedircon script does the opposite.
> 
> This change was present in the modified diff Dan sent and I preserved
> that change in the patch set.  At the time I had thought it was moved
> to make the output better match the python script but that appears not
> to be the case.
> 
> It is easy to change back but I'm sure there was a reason for the move.
> Perhaps Dan can shed some light on this.
> 
>  - todd
THe problem was the fallback_user was not determined at the time it was
being written out.  I have sent a new patch that separates out the
descovery of the fallback_user from gen_users.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG/RqurlYvE4MpobMRArtLAJ9zp2AKWoO6jUvB25bYYZl19t8KwACfeA5k
XSwO4xxrQgvgvsBU10nUyBs=
=CxFA
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
