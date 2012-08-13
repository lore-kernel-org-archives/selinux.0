Message-ID: <1344861108.25589.13.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SE Android (Was: Re: Welcome to selinux)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Date: Mon, 13 Aug 2012 08:31:48 -0400
In-Reply-To: <CAKi3PurM8Ps=riqe38vzFL6VD-qSYZHO0UOZjE7mBrygua6toA@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-08-13 at 10:37 +0200, Alexandra Test wrote:
> My version was a bit old so I decided to update it.
> 
> Unfortunately it cannot succeed, this is the error:
> update-apt-xapian-index has closedReceiving objects:  82% (4843/5898),
> 299.71 Mifatal: The remote end hung up unexpectedly65 MiB | 411
> KiB/s    
> fatal: early EOF
> fatal: index-pack failed
> remote: Counting objects: 5898, done.
> remote: Compressing objects: 100% (2778/2778), done.
> ^Cerror: Cannot fetch device-samsung-tuna77 MiB | 400 KiB/s  
> 
> I am using the master version. If I look into the folder it did not
> write anything inside...

Previously discussed on list (subject was "Cloning Android repo's from
bitbucket").  The problem is that the tuna project is very large and
apparently git clone via https falls over for such a large project from
bitbucket.org.  Options for resolving:

1) Switch to using ssh access.  Requires creating a registered bitbucket
account first with ssh keys.  To use this approach, create an account on
bitbucket.org, upload your public ssh key, and switch to the master-ssh
branch of the manifests project to get the local_manifest.xml file using
ssh access.

-or-

2) Do your repo sync first without the local_manifest.xml file (i.e.
just download AOSP), then move the local_manifest.xml file into place
and run repo sync again.  This should fetch the original projects from
AOSP which in turn should reduce what it has to fetch from bitbucket.org
to just our changes.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
