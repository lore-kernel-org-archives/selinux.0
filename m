Subject: RE: [PATCH v2] libsemanage:  Enable configuration of bzip behavior
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1249395755.9193.89.camel@moss-pluto.epoch.ncsc.mil>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
	 <1249388013.9193.52.camel@moss-pluto.epoch.ncsc.mil>
	 <1249389656.9193.73.camel@moss-pluto.epoch.ncsc.mil>
	 <1249392325.9193.76.camel@moss-pluto.epoch.ncsc.mil>
	 <1249394880.9193.80.camel@moss-pluto.epoch.ncsc.mil>
	 <06A6610D4F464D4EBEAFBF2C5F86911E0133DE4A@exchange2.columbia.tresys.com>
	 <1249395755.9193.89.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 04 Aug 2009 10:40:39 -0400
Message-Id: <1249396839.9193.98.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-04 at 10:22 -0400, Stephen Smalley wrote:
> On Tue, 2009-08-04 at 10:11 -0400, Joshua Brindle wrote:
> > > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > > 
> > > Allow the administrator to customize the bzip block size and "small"
> > > flag via semanage.conf.  After applying you can add entries 
> > > like these to your /etc/selinux/semanage.conf to trade off 
> > > memory vs disk space (block size) and to trade off memory vs 
> > > runtime (small):
> > > 
> > > bzip-blocksize=4
> > > bzip-small=1
> > > 
> > > You can also disable bzip compression altogether for your module store
> > > via:
> > > bzip-blocksize=0
> > > 
> > 
> > Are these the right config entries for everyone? Why not just have a max
> > compression, less compression, no compression kind of scheme? How badly
> > can you mess up the compression by putting semi-random values in these
> > fields?
> 
> The default values in the absence of any semanage.conf entries will
> remain blocksize 9, small 0 (i.e. maximize compression and minimize
> decompression runtime at a cost in memory use).  If the admin chooses to
> configure entries in semanage.conf, then he can use any value from 0 (no
> compression) through 9 for blocksize, and if he uses anything outside of
> that range he'll get an error upon attempting to insert a module (it
> will fail in bzip when trying to write the module file).  bzip-small
> gets treated as a boolean so any non-zero value will cause it to
> optimize for memory use over runtime during decompression.
> 
> I can't see any situation where the admin can hurt himself without
> knowing about it, as it requires manual configuration to change the
> defaults, setting bzip-blocksize > 9 will be immediately evident upon
> the next attempt to run semodule, setting bzip-small to any non-zero
> value is treated identically to setting it to 1, and the two values are
> completely independent of one another.  And admins will already be
> familiar with the -1 through -9 options of bzip2 and gzip.

Added range checking for bzip-blocksize, and changed bzip-small to a
boolean in the config in the latest patch version.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
