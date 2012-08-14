Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7EFgUPG025949
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2012 11:46:04 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb [147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7EFcSUE019721
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2012 08:38:28 -0700 (PDT)
From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: SE Android (Was: Re: Welcome to selinux)
Date: Tue, 14 Aug 2012 15:38:27 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E3836516B314@ALA-MBA.corp.ad.wrs.com>
References: <201206211329.q5LDT6PW031262@tarius.tycho.ncsc.mil>
	 <CAKi3Pur-Ne8vAfbw6t4hutrqJO73x=wOaHvTg8dca4W-LUOuLg@mail.gmail.com>
	 <1340288275.4234.48.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PuqSFBw8EHLCXuASBxoMEEX4wTuW0MZOdEURO5_GWTVcnA@mail.gmail.com>
	 <CAKi3PurC2T92r2mhzPKj7WoYb0Rf5Foz3W332Nov=Q5HZ8Ac3g@mail.gmail.com>
	 <CAKi3Puqf0u=H379cBk+uXtSNCbpQjtM-cDcyTifDGG8CdV93nA@mail.gmail.com>
	 <1340980684.15948.7.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PupzMRZsYzPAj_U0ff_QyN1VJUkVB9mciL=D_K3Hinm5AQ@mail.gmail.com>
	 <1341866938.10134.23.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Pup04kG+JPu+oudi1Bet2d0S=dz1t1RDwiYuFLLtHkCV4g@mail.gmail.com>
	 <CADQgGG35SABA6ZjDneqeGOrvbLT722Pvxsn6=G5S744d-TPxoA@mail.gmail.com>
	 <CAKi3PuqyCBS1fzjhSh1TVRsXCxR2_UnxXJG5ZCFL2XzF91MP4A@mail.gmail.com>
	 <CADQgGG1ry-x+0B2LHjY_SPvDiyUWBq4Pa5BVf6bFVokWvV3=qQ@mail.gmail.com>
	 <CAKi3PurKGD7-HibnqcCiJYjFzYMu0Nb2D5BcuGCMCLEE8wbpQg@mail.gmail.com>
	 <CADQgGG2dr4U36Pajg5XY1-vJO0uFszrpA2hXi6B-AwuBzyhbhQ@mail.gmail.com>
	 <CAKi3PuqfNoefmyOMx5Q0OnnGeBHUVvJP5Ebb1Adh_HpCPwYvtA@mail.gmail.com>
	 <CAKi3Pur20_u_BFEkHm++OydrN4zCm+o0jSzeY04DpmQ+aAOmqA@mail.gmail.com>
	 <CAFftDdrDSKKeXJga_PO0LJiUsqb3VVMjnSNQFWF66K7QrJ43Bg@mail.gmail.com>
	 <CAKi3Puo0PqmsVkcTqJRDhNq5w6J_yVdS=_MPNSC28K0QP0CxXQ@mail.gmail.com>
	 <CAFftDdqD+o=hXRyCP5nKc4OmELX50XLWAL2t-9VPi_vKPB-grA@mail.gmail.com>
	 <CAKi3Pur1UD+_6YrZ6gj9sJ4yef6Yfim=OOi6R-Lek5Beo41LQw@mail.gmail.com>
	 <CAFftDdrUz4NkMKd29rLnhddE1B0dLtJA8DbGZqucovsNbsqo0w@mail.gmail.com>
	 <CAKi3PupwHSYPcRYyUNEeXM3py-FjtbrZUd5nGDUwfdwdKRgVZw@mail.gmail.com>
	 <CAFftDdocfYJd5JukcFMut+CuKmxCQ5TsNnGr=zb29qyRGKvLyA@mail.gmail.com>
	 <CAKi3Pup5Om=x28GW=j=LTC9z8GgrcwUoty6w8hQnPJpNaJE91w@mail.gmail.com>
	 <CAFftDdok-0k8NjvgQkxHWdv=SMGOLYbsAkUVSBsFBz1f8Tm0Kg@mail.gmail.com>
	 <CAKi3PurM8Ps=riqe38vzFL6VD-qSYZHO0UOZjE7mBrygua6toA@mail.gmail.com>
	 <CAFftDdozQQH7skpco0XtJ2HS_yjd1AYS8tNbFqQLkS9oDWEqYg@mail.gmail.com>
	 <CAKi3PuoLSeTfB208zU4mwUtYTmYMnhbjOWbTSMsyfEhOE1nVFQ@mail.gmail.com>,<1344954794.5588.49.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1344954794.5588.49.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I've seen similar problems in the past, it was usually (always?) caused because a git pull or git clone had been interrupted at the wrong place.  My normal workaround is to remove the corrupted project.  In this case, I think that may be "rm -rf .repo/projects/dalvik.git dalvik"


________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of Stephen Smalley [sds@tycho.nsa.gov]
Sent: Tuesday, August 14, 2012 7:33 AM
To: Alexandra Test
Cc: William Roberts; selinux@tycho.nsa.gov
Subject: Re: SE Android (Was: Re: Welcome to selinux)

On Tue, 2012-08-14 at 12:42 +0200, Alexandra Test wrote:
> When I try to check out the aosp, it fails with this error
>  File "/home/ubuntu-user/Selinux/.repo/repo/main.py", line 385, in
> <module>
>     _Main(sys.argv[1:])
>   File "/home/ubuntu-user/Selinux/.repo/repo/main.py", line 365, in
> _Main
>     result = repo._Run(argv) or 0
>   File "/home/ubuntu-user/Selinux/.repo/repo/main.py", line 137, in
> _Run
>     result = cmd.Execute(copts, cargs)
>   File "/home/ubuntu-user/Selinux/.repo/repo/subcmds/sync.py", line
> 469, in Execute
>     project.Sync_LocalHalf(syncbuf)
>   File "/home/ubuntu-user/Selinux/.repo/repo/project.py", line 1049,
> in Sync_LocalHalf
>     lost = self._revlist(not_rev(revid), HEAD)
>   File "/home/ubuntu-user/Selinux/.repo/repo/project.py", line 1791,
> in _revlist
>     return self.work_git.rev_list(*a, **kw)
>   File "/home/ubuntu-user/Selinux/.repo/repo/project.py", line 1936,
> in rev_list
>     p.stderr))
> error.GitError: dalvik rev-list
> ('^938208a28b56f360c6cb0fb3a5e57d6121924a93', 'HEAD', '--'): fatal:
> bad object HEAD
>
> Any idea?

No, never seen that one.  Try creating a fresh client in an empty
directory (without any .repo subdirectory) from AOSP.  Might want to
also make sure you are using an up-to-date version of repo.

--
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
