Message-ID: <1343665109.2346.70.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SEAndroid 4.0.4 make error since the code move
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Gia T. Nguyen" <gia.nguyen@metronome-software.com>
Cc: selinux@tycho.nsa.gov
Date: Mon, 30 Jul 2012 12:18:29 -0400
In-Reply-To: <1343664799.2346.68.camel@moss-pluto.epoch.ncsc.mil>
References: <CC3C2203.6A7B%gia.nguyen@metronome-software.com>
	 <1343664799.2346.68.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-30 at 12:13 -0400, Stephen Smalley wrote:
> On Mon, 2012-07-30 at 11:35 -0400, Gia T. Nguyen wrote:
> > 
> > 
> > Hi everyone,
> > 
> > 
> > I needed to go back and pull the 4.0.4 source, so I followed these
> > instructions from the website:
> > 
> > 
> > git clone -b seandroid-4.0.4
> > https://bitbucket.org/seandroid/manifests.git
> > mkdir seandroid-4.0.4
> > cd seandroid-4.0.4
> > repo init -u https://android.googlesource.com/platform/manifest -b
> > android-4.0.4_r2.1
> > cp ../manifests/local_manifest.xml .repo/
> > repo sync
> > 
> > 
> > However, now I'm getting these make errors when I'm building:
> > 
> > 
> > <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined [enabled by
> > default]
> > <command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]
> > <built-in>:0:0: note: this is the location of the previous definition
> > cc1plus: all warnings being treated as errors
> > make: ***
> > [out/host/linux-x86/obj/EXECUTABLES/obbtool_intermediates/Main.o]
> > Error 1
> > 
> > 
> > Has anyone else seen this since the move of the code to git?
> 
> That's not SE Android specific; it just means you are building 4.0.4 on
> an unsupported build host OS.  So you can either use a supported build
> host OS for 4.0.4 or manually apply the corresponding build fixes that
> already exist on master.

Per prior discussions on android-building, this can be worked around by
changing build/core/combo/HOST_linux-x86.mk, replacing:
HOST_GLOBAL_CFLAGS += -D_FORTIFY_SOURCE=0
with:
HOST_GLOBAL_CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0

But you may run into other issues building 4.0.4 with an unsupported
build host OS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
