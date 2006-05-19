Date: Fri, 19 May 2006 13:04:03 -0400
From: Maria Iano <maria@iano.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: correct way to set context in perl?
Message-ID: <20060519130403.C26098@iano.org>
References: <20060518160656.V26098@iano.org> <1147985248.3617.2.camel@wintermute.xmldesign.de> <20060518171245.Y26098@iano.org> <200605192357.39325.russell@coker.com.au> <20060519103127.A26098@iano.org> <20060519113334.B26098@iano.org> <1148053480.25168.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148053480.25168.150.camel@moss-spartans.epoch.ncsc.mil>; from sds@tycho.nsa.gov on Fri, May 19, 2006 at 11:44:40AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You're right - I'll move the context types into the config file. I'll use the -t option as you suggest as well. Thanks very much for your help.

I have a pair of .te and .fc files for my application, so next time it boots they will get labelled correctly anyway.

Generating perl bindings is probably way out of my league, but I will take a look at it.

Every time a zone is edited, the scripts append the diffs to a running log file of diffs for that zone. These files are kept in a directory called diffs and the name server never needs to read or write to them, so I gave it type etc_t because I don't know any better. So here is how it looks now:

my $namedpath;
if ($ARGV[0] =~ /--dir=([^)]+)/) {
    $namedpath = $1;
} else {
    $namedpath = $config->{fulldirectory};
}
my $master_type = $config->{master_type} || 'named_zone_t';
my $slave_type = $config->{slave_type} || 'named_cache_t';
my $diff_type = $config->{diff_type} || 'etc_t';
my $named_dir_type = $config->{named_dir_type} || $master_type;

unless ($namedpath) {
    die "The zone path was not found in the configuration file";
}
unless (-e $namedpath) {
    die "Could not create directory $namedpath" unless mkdir($namedpath,0770);
    system ('chcon','-t',$named_dir_type,"$namedpath");
}
unless (-e "$namedpath/slaves") {
    die "Could not create directory $namedpath/slaves"
                  unless mkdir("$namedpath/slaves",0770);
    system ('chcon','-t',$slave_type,"$namedpath/slaves");
}
unless (-e "$namedpath/diffs") {
    die "Could not create directory $namedpath/diffs"
                  unless mkdir("$namedpath/diffs",0770);
    system ('chcon','-t',$diff_type,"$namedpath/diffs");
}
my $masterpath = "$namedpath/master";
unless (-e $masterpath) {
    die "Could not create directory $masterpath" unless mkdir($masterpath,0770);
    system ('chcon','-t',$master_type,"$masterpath");
}

Thanks for your help,
Maria

On Fri, May 19, at 11:44%P so wrote Stephen Smalley (sds@tycho.nsa.gov):

> On Fri, 2006-05-19 at 11:33 -0400, Maria Iano wrote:
> > Even after reorganizing the directories I still see the need for setting context from a perl script. The first time the application runs the directories may not be there. So I've added this to one of the scripts, and it does seem to do what I need. I would appreciate any comments/advice on a better approach to this:
> > 
> > unless ($zonepath) {
> >     die "The zone path was not found in the configuration file";
> > }
> > unless (-e $zonepath) {
> >     die "Could not create directory $zonepath" unless mkdir($zonepath,0770);
> >     system ("chcon","system_u:object_r:named_zone_t","$zonepath");
> >     die "Could not create directory $zonepath/slaves"
> >                   unless mkdir("$zonepath/slaves",0770);
> >     system ("chcon","system_u:object_r:named_cache_t","$zonepath/slaves");
> > }
> > my $datapath = "$zonepath/master";
> > unless (-e $datapath) {
> >     die "Could not create directory $datapath" unless mkdir($datapath,0770);
> >     system ("chcon","system_u:object_r:named_zone_t","$datapath");
> > }
> 
> If using chcon, use the -t option so that you only need to specify the
> type (named_zone_t) and let the rest of the context be inferred.
> Ideally, you'd get even the type name from some config file.
> 
> python bindings have been added to libselinux via swig; generating perl
> bindings might be simple, particularly for simple functions like
> setfilecon(3).
> 
> -- 
> Stephen Smalley
> National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
