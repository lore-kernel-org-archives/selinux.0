Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42GaqoG005756
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:36:52 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42Gap4f020267
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 16:36:51 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k42GbC7N011889
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:37:12 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k42GbC0L011888
	for selinux@tycho.nsa.gov; Tue, 2 May 2006 12:37:12 -0400
Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Paul Nasrat <pnasrat@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>,
        SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>,
        Jeremy Katz <katzj@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
References: <44576B91.8060607@redhat.com>
	 <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 May 2006 11:27:35 -0400
Message-Id: <1146583655.2737.25.camel@enki.eridu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 11:12 -0400, Stephen Smalley wrote:

> > Secondly the rpm team would like to be able to execute the equivalent of 
> > matchpathcon(XYZ.pp)  IE be able to extract the FC file mapping from the 
> > policy package and combine it with the on disk representation to 
> > determine the file context to associate with the new files being put on 
> > disk.
> 
> This shouldn't be difficult to implement, but it is only necessary if
> you don't install the .pp file prior to labeling the files, which is
> really counter to the whole design.  You _can_ install the .pp file
> without immediately loading the new kernel policy (semodule -n -i x.pp),
> thereby rebuilding file_contexts, but that will still be a heavyweight
> operation, so you still want to batch them up.

The point here is to capture the file contexts at build time, not at
install time - as a packager with policy I may not have the ability to
install policy on my build host.

The implementation in RPM currently supports querying file contexts in
headers, via matchpathcon and what is actually on the filesystem.  The
point here was to enable us to correctly set the header contexts, as
when we are laying files on disk we might not have put the pp file down
yet.  Changing RPM to extract specific file types from each package at
transaction run is not a desirable change, we already can look up
contexts - on FC5 where policy was in the build roots you can do:

rpm --qf '[%{filenames} %{filecontexts}\n]' -q rpm

If we had
%install
install -m 600 foo.pp $RPM_BUILD_ROOT/%{policy_dir}/foo.pp

%policy %{policy_dir}/foo.pp

Then the context header population in the RPM header could use the pp
file for that information via matchpathcon or equivalent.

Paul

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
