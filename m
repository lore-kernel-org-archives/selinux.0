Message-ID: <1347996415.31966.118.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Upstream changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 18 Sep 2012 15:26:55 -0400
In-Reply-To: <CAFftDdrj0numzkrn1Ot_UE25SadOyapGbPhRqya1OgJPByZd7g@mail.gmail.com>
References: 
	<CAFftDdqrZPWj8C3ht1=FGXjh7f2szgamq8qbU1RMwgGh3Lvxkg@mail.gmail.com>
	 <1347979342.31966.1.camel@moss-pluto.epoch.ncsc.mil>
	 <CAFftDdrj0numzkrn1Ot_UE25SadOyapGbPhRqya1OgJPByZd7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-09-18 at 09:35 -0700, William Roberts wrote:
> I think we just start dropping ones were not maintaining.

I dropped our libsepol, libselinux, checkpolicy, and sepolicy projects
from the local_manifest.xml file on master and master-ssh, so you will
just get the AOSP versions going forward there.  We still need them on
the 4.0.4 and 4.1.1 branches as they didn't exist for 4.0.4 and the
versions that existed when jb was branched are quite out of date.

> On Sep 18, 2012 7:45 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>         On Mon, 2012-09-17 at 20:17 -0700, William Roberts wrote:
>         > Now that changes are going through Gerrit into AOSP's repos,
>         will
>         > selinux/bitbucket version of repositories consistently pull
>         aosp
>         > changes and merge them?
>         
>         I just updated them.  I'll add them to the set that we pull
>         from aosp
>         periodically now that we are developing directly on aosp.  Or
>         we could
>         drop our local ones from the local_manifest.xml files at this
>         point?
>         
>         --
>         Stephen Smalley
>         National Security Agency
>         

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
