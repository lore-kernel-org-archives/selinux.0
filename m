Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79D91k1029789
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 09:09:01 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l79D90c5012887
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:09:00 GMT
Subject: Re: Fedora/SE-PostgreSQL
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, dwalsh@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <46BAF780.6030507@kaigai.gr.jp>
References: <46B079EF.9050909@kaigai.gr.jp> <1186489529.18881.9.camel@gorn>
	 <46B878D9.6090004@ak.jp.nec.com> <1186495764.18881.17.camel@gorn>
	 <46B8ABC5.60705@kaigai.gr.jp>  <46BAF780.6030507@kaigai.gr.jp>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 13:08:27 +0000
Message-Id: <1186664907.25504.16.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 20:16 +0900, KaiGai Kohei wrote:
> KaiGai Kohei wrote:
> > The attached patch adds definitions of new classes and permissions,
> > and MLS/MCS rules.

Merged.

> > Following items are differences from the first patch.
> > 
> > * add "db_" prefix for each object classes.
> >   e.g) "table" -> "db_table"
> > * interfaces in policy/modules/kernel/mls.if are renamed.
> >   - mls_database_read_up    -> mls_db_read_all_levels
> >   - mls_database_write_down -> mls_db_write_all_levels
> >   - mls_database_upgrade    -> mls_db_upgrade
> >   - mls_database_downgrade  -> mls_db_downgrade
> > * MLS attributes related to database are renamed
> >   - mlsdatabaseXXXXX -> mlsdbXXXXX
> 
> Oops, the following attributes were not renamed in the previous patch,
> 
> | +mlsconstrain { db_tuple } { use select }
> | +       (( l1 dom l2 ) or
> | +        (( t1 == mlsdatabasereadtoclr ) and ( h1 dom l2 )) or
> | +        ( t1 == mlsdatabaseread ) or
> | +        ( t2 == mlstrustedobject ));
> 
> The attached one (v3) fixes them.
> I want it to be applied.
> 
> Thanks,
> plain text document attachment
> (refpolicy-add-sepgsql-definitions.v3.patch)
> Index: refpolicy/policy/flask/security_classes
> ===================================================================
> --- refpolicy/policy/flask/security_classes	(revision 2386)
> +++ refpolicy/policy/flask/security_classes	(working copy)
> @@ -99,4 +99,12 @@
>  
>  class memprotect
>  
> +# SE-PostgreSQL relation
> +class db_database		# userspace
> +class db_table			# userspace
> +class db_procedure		# userspace
> +class db_column			# userspace
> +class db_tuple			# userspace
> +class db_blob			# userspace
> +
>  # FLASK
> Index: refpolicy/policy/flask/access_vectors
> ===================================================================
> --- refpolicy/policy/flask/access_vectors	(revision 2386)
> +++ refpolicy/policy/flask/access_vectors	(working copy)
> @@ -80,6 +80,20 @@
>  }
>  
>  #
> +#  Define a common prefix for userspace database object access
> vectors.
> +#
> +
> +common database
> +{
> +	create
> +	drop
> +	getattr
> +	setattr
> +	relabelfrom
> +	relabelto
> +}
> +
> +#
>  # Define the access vectors.
>  #
>  # class class_name [ inherits common_name ] { permission_name ... }
> @@ -655,3 +669,61 @@
>  {
>  	mmap_zero
>  }
> +
> +# definition for SE-PostgreSQL
> +class db_database
> +inherits database
> +{
> +	access
> +	install_module
> +	load_module
> +	get_param
> +	set_param
> +}
> +
> +class db_table
> +inherits database
> +{
> +	use
> +	select
> +	update
> +	insert
> +	delete
> +	lock
> +}
> +
> +class db_procedure
> +inherits database
> +{
> +	execute
> +	entrypoint
> +}
> +
> +class db_column
> +inherits database
> +{
> +	use
> +	select
> +	update
> +	insert
> +}
> +
> +class db_tuple
> +{
> +	relabelfrom
> +	relabelto
> +	use
> +	select
> +	update
> +	insert
> +	delete
> +}
> +
> +class db_blob
> +inherits database
> +{
> +	read
> +	write
> +	import
> +	export
> +}
> Index: refpolicy/policy/mcs
> ===================================================================
> --- refpolicy/policy/mcs	(revision 2386)
> +++ refpolicy/policy/mcs	(working copy)
> @@ -98,4 +98,28 @@
>  mlsconstrain process { sigkill sigstop }
>  	(( h1 dom h2 ) or ( t1 == mcskillall ));
>  
> +# MCS policy for SE-PostgreSQL
> +#-------------------------------
> +
> +# Any database object must be dominated by the relabeling subject
> +# clearance, also the objects are single-level.
> +mlsconstrain { db_database db_table db_procedure db_column db_blob }
> { create relabelto }
> +	((h1 dom h2) and ( l2 eq h2 ));
> +mlsconstrain { db_tuple } { insert relabelto }
> +	(( h1 dom h2 ) and ( l2 eq h2 ));
> +
> +# Access control for any database objects based on MCS rules.
> +mlsconstrain db_database { drop setattr relabelfrom access
> install_module load_module get_param set_param }
> +	( h1 dom h2 );
> +mlsconstrain db_table { drop setattr relabelfrom select update insert
> delete use }
> +	( h1 dom h2 );
> +mlsconstrain db_column { drop setattr relabelfrom select update
> insert use }
> +	( h1 dom h2 );
> +mlsconstrain db_tuple { relabelfrom select update delete use }
> +	( h1 dom h2 );
> +mlsconstrain db_procedure { execute }
> +	( h1 dom h2 );
> +mlsconstrain db_blob { drop setattr relabelfrom read write }
> +	( h1 dom h2 );
> +
>  ') dnl end enable_mcs
> Index: refpolicy/policy/modules/kernel/mls.te
> ===================================================================
> --- refpolicy/policy/modules/kernel/mls.te	(revision 2386)
> +++ refpolicy/policy/modules/kernel/mls.te	(working copy)
> @@ -43,6 +43,14 @@
>  attribute mlsxwinwritecolormap;
>  attribute mlsxwinwritexinput;
>  
> +attribute mlsdbread;
> +attribute mlsdbreadtoclr;
> +attribute mlsdbwrite;
> +attribute mlsdbwritetoclr;
> +attribute mlsdbwriteinrange;
> +attribute mlsdbupgrade;
> +attribute mlsdbdowngrade;
> +
>  attribute mlstrustedobject;
>  
>  attribute privrangetrans;
> Index: refpolicy/policy/modules/kernel/mls.if
> ===================================================================
> --- refpolicy/policy/modules/kernel/mls.if	(revision 2386)
> +++ refpolicy/policy/modules/kernel/mls.if	(working copy)
> @@ -406,6 +406,82 @@
>  
>  ########################################
>  ## <summary>
> +##      Make specified domain MLS trusted
> +##      for reading from databases at higher levels.
> +## </summary>
> +## <param name="domain">
> +##      <summary>
> +##      Domain allowed access.
> +##      </summary>
> +## </param>
> +#
> +interface(`mls_db_read_all_levels',`
> +	gen_require(`
> +		attribute mlsdbread;
> +	')
> +
> +	typeattribute $1 mlsdbread;
> +')
> +
> +########################################
> +## <summary>
> +##       Make specified domain MLS trusted
> +##       for writing to databases at lower levels.
> +## </summary>
> +## <param name="domain">
> +##      <summary>
> +##      Domain allowed access.
> +##      </summary>
> +## </param>
> +#
> +interface(`mls_db_write_all_levels',`
> +	gen_require(`
> +		attribute mlsdbwrite;
> +	')
> +
> +	typeattribute $1 mlsdbwrite;
> +')
> +
> +########################################
> +## <summary>
> +##      Make specified domain MLS trusted
> +##      for raising the level of databases.
> +## </summary>
> +## <param name="domain">
> +##      <summary>
> +##      Domain allowed access.
> +##      </summary>
> +## </param>
> +#
> +interface(`mls_db_upgrade',`
> +	gen_require(`
> +		attribute mlsdbupgrade;
> +	')
> +
> +	typeattribute $1 mlsdbupgrade;
> +')
> +
> +########################################
> +## <summary>
> +##      Make specified domain MLS trusted
> +##      for lowering the level of databases.
> +## </summary>
> +## <param name="domain">
> +##      <summary>
> +##      Domain allowed access.
> +##      </summary>
> +## </param>
> +#
> +interface(`mls_db_downgrade',`
> +	gen_require(`
> +		attribute mlsdbdowngrade;
> +	')
> +
> +	typeattribute $1 mlsdbdowngrade;
> +')
> +
> +########################################
> +## <summary>
>  ##	Make specified object MLS trusted.
>  ## </summary>
>  ## <desc>
> Index: refpolicy/policy/mls
> ===================================================================
> --- refpolicy/policy/mls	(revision 2386)
> +++ refpolicy/policy/mls	(working copy)
> @@ -600,4 +600,96 @@
>  mlsconstrain context contains
>  	( h1 dom h2 );
>  
> +#
> +# MLS policy for the database related classes
> +#
> +
> +# make sure these database classes are "single level"
> +mlsconstrain { db_database db_table db_procedure db_column db_blob }
> { create relabelto }
> +	( l2 eq h2 );
> +mlsconstrain { db_tuple } { insert relabelto }
> +	( l2 eq h2 );
> +
> +# new database labels must be dominated by the relabeling subjects
> clearance
> +mlsconstrain { db_database db_table db_procedure db_column db_tuple
> db_blob } { relabelto }
> +	( h1 dom h2 );
> +
> +# the database "read" ops (note the check is dominance of the low
> level)
> +mlsconstrain { db_database } { getattr access get_param }
> +	(( l1 dom l2 ) or
> +	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
> +	 ( t1 == mlsdbread ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +mlsconstrain { db_table db_column } { getattr use select }
> +	(( l1 dom l2 ) or
> +	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
> +	 ( t1 == mlsdbread ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +mlsconstrain { db_procedure } { getattr execute }
> +	(( l1 dom l2 ) or
> +	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
> +	 ( t1 == mlsdbread ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +mlsconstrain { db_blob } { getattr read }
> +	(( l1 dom l2 ) or
> +	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
> +	 ( t1 == mlsdbread ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +mlsconstrain { db_tuple } { use select }
> +	(( l1 dom l2 ) or
> +	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
> +	 ( t1 == mlsdbread ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +# the "single level" file "write" ops
> +mlsconstrain { db_database } { create drop setattr relabelfrom
> install_module load_module set_param }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 ))
> or
> +	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 ))
> or
> +	 ( t1 == mlsdbwrite ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +mlsconstrain { db_table } { create drop setattr relabelfrom update
> insert delete lock }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 ))
> or
> +	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 ))
> or
> +	 ( t1 == mlsdbwrite ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +mlsconstrain { db_column } { create drop setattr relabelfrom update
> insert }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 ))
> or
> +	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 ))
> or
> +	 ( t1 == mlsdbwrite ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +mlsconstrain { db_blob } { create drop setattr relabelfrom write
> import export }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 ))
> or
> +	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 ))
> or
> +	 ( t1 == mlsdbwrite ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +mlsconstrain { db_tuple } { relabelfrom update insert delete }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 ))
> or
> +	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 ))
> or
> +	 ( t1 == mlsdbwrite ) or
> +	 ( t2 == mlstrustedobject ));
> +
> +# the database upgrade/downgrade rule
> +mlsvalidatetrans { db_database db_table db_procedure db_column
> db_tuple db_blob }
> +	((( l1 eq l2 ) or
> +	  (( t3 == mlsdbupgrade ) and ( l1 domby l2 )) or
> +	  (( t3 == mlsdbdowngrade ) and ( l1 dom l2 )) or
> +	  (( t3 == mlsdbdowngrade ) and ( l1 incomp l2 ))) and
> +	 (( l1 eq h2 ) or
> +	  (( t3 == mlsdbupgrade ) and ( h1 domby h2 )) or
> +	  (( t3 == mlsdbdowngrade ) and ( h1 dom h2 )) or
> +	  (( t3 == mlsdbdowngrade ) and ( h1 incomp h2 ))));
> +
>  ') dnl end enable_mls
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
