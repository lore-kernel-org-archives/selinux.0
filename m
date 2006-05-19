Subject: Re: correct way to set context in perl?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Maria Iano <maria@iano.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20060519113334.B26098@iano.org>
References: <20060518160656.V26098@iano.org>
	 <1147985248.3617.2.camel@wintermute.xmldesign.de>
	 <20060518171245.Y26098@iano.org> <200605192357.39325.russell@coker.com.au>
	 <20060519103127.A26098@iano.org>  <20060519113334.B26098@iano.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 11:44:40 -0400
Message-Id: <1148053480.25168.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-19 at 11:33 -0400, Maria Iano wrote:
> Even after reorganizing the directories I still see the need for setting context from a perl script. The first time the application runs the directories may not be there. So I've added this to one of the scripts, and it does seem to do what I need. I would appreciate any comments/advice on a better approach to this:
> 
> unless ($zonepath) {
>     die "The zone path was not found in the configuration file";
> }
> unless (-e $zonepath) {
>     die "Could not create directory $zonepath" unless mkdir($zonepath,0770);
>     system ("chcon","system_u:object_r:named_zone_t","$zonepath");
>     die "Could not create directory $zonepath/slaves"
>                   unless mkdir("$zonepath/slaves",0770);
>     system ("chcon","system_u:object_r:named_cache_t","$zonepath/slaves");
> }
> my $datapath = "$zonepath/master";
> unless (-e $datapath) {
>     die "Could not create directory $datapath" unless mkdir($datapath,0770);
>     system ("chcon","system_u:object_r:named_zone_t","$datapath");
> }

If using chcon, use the -t option so that you only need to specify the
type (named_zone_t) and let the rest of the context be inferred.
Ideally, you'd get even the type name from some config file.

python bindings have been added to libselinux via swig; generating perl
bindings might be simple, particularly for simple functions like
setfilecon(3).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
