Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1PEA6oS000694
 for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2015 09:10:10 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so33596761wiw.3
 for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2015 06:10:07 -0800 (PST)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id uc18sm8569524wib.0.2015.02.25.06.10.06
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 25 Feb 2015 06:10:06 -0800 (PST)
Date: Wed, 25 Feb 2015 15:10:05 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsepol: Update CIL documentation
Message-ID: <20150225141004.GA31751@linksys-wireless-usb.network2>
References: <1424872804-4311-1-git-send-email-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <1424872804-4311-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Feb 25, 2015 at 02:00:04PM +0000, Richard Haines wrote:
> Reformat secilc(8) man page for readability and correct url
> 
> Remove unused/obsolete info and correct portcon statement in the
> Reference Guide.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libsepol/cil/docs/CIL_Reference_Guide.xml          | 10 +--
>  .../cil/docs/cil_network_labeling_statements.xml   | 14 +++-
>  libsepol/cil/docs/secilc.8.xml                     | 92 ++++++++++++++--------
>  3 files changed, 71 insertions(+), 45 deletions(-)
> 
> diff --git a/libsepol/cil/docs/CIL_Reference_Guide.xml b/libsepol/cil/docs/CIL_Reference_Guide.xml
> index e905152..e089079 100644
> --- a/libsepol/cil/docs/CIL_Reference_Guide.xml
> +++ b/libsepol/cil/docs/CIL_Reference_Guide.xml
> @@ -27,26 +27,18 @@
>  <article lang="en_GB">
>     <articleinfo>
>        <title>Common Interface Language (CIL) Reference Guide</title>
> -      <revhistory>
> -         <revision>
> -            <revnumber>0.2</revnumber>
> -            <date>22nd May '14</date>
> -            <revremark>Updated classmap/classmapping, added classmap to statements that utilise class_id's (defaultuser, typetransition etc.), update various examples to show anonymous classpermissionset's using expressions.</revremark>
> -         </revision>
> -      </revhistory>
>     </articleinfo>
>  
>     <sect1>
>        <title>CIL Information</title>
>        <orderedlist>
> -         <listitem><para>The statement definitions are those found in the source from: <literal>git clone <ulink url="https://bitbucket.org/jwcarter/secilc.git"></ulink></literal> dated 21st May '14.</para></listitem>
>           <listitem><para>Not all possible alternate statement permutations are shown, however there should be enough variation to work out any other valid formats. There is also an example <filename>policy.cil</filename> file shown in the <link linkend="example_policy">Appendix</link>.</para></listitem>
>           <listitem><para>The MLS components on contexts and user statements must be declared even if the policy does not support MCS/MLS. </para></listitem>
>           <listitem><para>The CIL compiler will not build a policy unless it also has as a minimum: one <literal><link linkend="allow">allow</link></literal> rule, one <literal><link linkend="sid">sid</link></literal>, <literal><link linkend="sidorder">sidorder</link></literal> and <literal><link linkend="sidcontext">sidcontext</link></literal> statement. </para></listitem>
>           <listitem><para>The role <literal>object_r</literal> must be explicitly associated to contexts used for labeling objects. The original <emphasis role="bold"><literal>checkpolicy</literal></emphasis><literal>(8)</literal> and <emphasis role="bold"><literal>checkmodule</literal></emphasis><literal>(8)</literal> compilers did this by default - CIL does not.</para></listitem>
>           <listitem><para>Be aware that CIL allows <literal><link linkend="class">class</link></literal> statements to be declared in a namespace, however the policy author needs to note that applications (and the kernel) generally reference a class by its well known class identifier (e.g. <literal>zygote</literal>) however if declared in a namespace (e.g. <literal>(block zygote (class zygote (...)))</literal> or <literal>(block zygote (class class (...)))</literal>) it would be prefixed with that namespace (e.g. <literal>zygote.zygote</literal> or  <literal>zygote.class</literal>). Unless the application / kernel code was updated the class would never be resolved, therefore it is recommended that classes are declared in the global namespace.</para></listitem>
>           <listitem><para>Where possible use <literal><link linkend="typeattribute">typeattribute</link></literal>'s when defining source/target <literal><link linkend="allow">allow</link></literal> rules instead of multiple <literal>allow</literal> rules with individual <literal><link linkend="type">type</link></literal>'s. This will lead to the generation of much smaller kernel policy files.</para></listitem>
> -         <listitem><para>The <ulink url="http://userspace.selinuxproject.org/trac/wiki/CilDesign"></ulink> site explains the language however some of the statement definitions are dated.</para></listitem>
> +         <listitem><para>The <ulink url="http://github.com/SELinuxProject/cil/wiki"></ulink> site explains the language however some of the statement definitions are dated.</para></listitem>
>        </orderedlist>
>        <sect2>
>           <title>Declarations</title>
> diff --git a/libsepol/cil/docs/cil_network_labeling_statements.xml b/libsepol/cil/docs/cil_network_labeling_statements.xml
> index 785b583..1047108 100644
> --- a/libsepol/cil/docs/cil_network_labeling_statements.xml
> +++ b/libsepol/cil/docs/cil_network_labeling_statements.xml
> @@ -186,7 +186,7 @@
>           <title>portcon</title>
>           <para>Label a udp or tcp port.</para>
>           <para><emphasis role="bold">Statement definition:</emphasis></para>
> -         <programlisting><![CDATA[(portcon protocol port context_id)]]></programlisting>
> +         <programlisting><![CDATA[(portcon protocol port|(port_low port_high) context_id)]]></programlisting>
>           <para><emphasis role="bold">Where:</emphasis></para>
>           <informaltable frame="all">
>              <tgroup cols="2">
> @@ -211,6 +211,16 @@
>                 </row>
>                 <row>
>                    <entry>
> +                     <para><literal>port |</literal></para>
> +                     <para><literal>(port_low port_high)</literal></para>
> +                  </entry>
> +                  <entry>
> +                     <para>A single port to apply the context, or a range of ports.</para>
> +                     <para>The entries must consist of numerics <literal>[0-9]</literal>.</para>
> +                  </entry>
> +               </row>
> +               <row>
> +                  <entry>
>                       <para><literal>context_id</literal></para>
>                    </entry>
>                    <entry>
> @@ -227,7 +237,7 @@
>  (portcon tcp 2222 (unconfined.user object_r unconfined.object levelrange_2))
>  (portcon tcp 3333 (unconfined.user object_r unconfined.object levelrange_1))
>  (portcon udp 4444 (unconfined.user object_r unconfined.object ((s0) level_2)))
> -(portcon tcp 55555 (unconfined.user object_r unconfined.object (systemlow level_3)))]]>
> +(portcon tcp (2000 20000) (unconfined.user object_r unconfined.object (systemlow level_3)))]]>
>           </programlisting>
>        </sect2>
>  
> diff --git a/libsepol/cil/docs/secilc.8.xml b/libsepol/cil/docs/secilc.8.xml
> index 12d72b7..9e2670b 100644
> --- a/libsepol/cil/docs/secilc.8.xml
> +++ b/libsepol/cil/docs/secilc.8.xml
> @@ -12,7 +12,7 @@
>     <refmeta>
>        <refentrytitle>SECILC</refentrytitle>
>        <manvolnum>8</manvolnum>
> -      <refmiscinfo class="date">12 May 2014</refmiscinfo>
> +      <refmiscinfo class="date">18 February 2015</refmiscinfo>
>        <refmiscinfo class="source">secilc</refmiscinfo>
>        <refmiscinfo class="manual">SELinux CIL Compiler</refmiscinfo>
>     </refmeta>
> @@ -34,38 +34,62 @@
>     </refsect1>
>  
>     <refsect1 id="options"><title>OPTIONS</title>
> -      <para><option>-o, --output=&lt;file></option></para>
> -      <para>Write binary policy to <emphasis role="italic">file</emphasis> (default: policy.<emphasis role="italic">version</emphasis>)</para>
> -
> -      <para><option>-f, --filecontext=&lt;file></option></para>
> -      <para>Write file contexts to <emphasis role="italic">file</emphasis> (default: <emphasis role="bold">file_contexts</emphasis>)</para>
> -
> -      <para><option>-t, --target=&lt;type></option></para>
> -      <para>Specify target architecture. May be <emphasis role="bold">selinux</emphasis> or <emphasis role="bold">xen</emphasis> (default: <emphasis role="bold">selinux</emphasis>)</para>
> -
> -      <para><option>-M, --mls true|false</option></para>
> -      <para>Build an mls policy. Must be <emphasis role="bold">true</emphasis> or <emphasis role="bold">false</emphasis>. This will override the <emphasis role="bold">(mls <emphasis role="italic">boolean</emphasis></emphasis><emphasis role="bold">)</emphasis> statement if present in the policy.</para>
> -
> -      <para><option>-c, --policyvers=&lt;version></option></para>
> -      <para>Build a binary policy with a given <emphasis role="italic">version</emphasis> (default: depends on the systems SELinux policy <emphasis role="italic">version</emphasis>, see <citerefentry><refentrytitle>sestatus</refentrytitle><manvolnum>8</manvolnum></citerefentry>)</para>
> -
> -      <para><option>-U, --handle-unknown=&lt;action></option></para>
> -      <para>How to handle unknown classes or permissions. May be <emphasis role="bold">deny</emphasis>, <emphasis role="bold">allow</emphasis>, or <emphasis role="bold">reject</emphasis> (default: <emphasis role="bold">deny</emphasis>). This will override the <emphasis role="bold">(handleunknown <emphasis role="italic">action</emphasis></emphasis><emphasis role="bold">)</emphasis> statement if present in the policy.</para>
> -
> -      <para><option>-D, --disable-dontaudit</option></para>
> -      <para>Do not add <emphasis role="bold">dontaudit</emphasis> rules to the binary policy.</para>
> -
> -      <para><option>-P, --preserve-tunables</option></para>
> -      <para>Treat tunables as booleans.</para>
> -
> -      <para><option>-N, --disable-neverallow</option></para>
> -      <para>Do not check <emphasis role="bold">neverallow</emphasis> rules.</para>
> -
> -      <para><option>-v, --verbose</option></para>
> -      <para>Increment verbosity level.</para>
> -
> -      <para><option>-h, --help</option></para>
> -      <para>Display usage information.</para>
> +      <variablelist>
> +         <varlistentry>
> +            <term><option>-o, --output=&lt;file></option></term>
> +            <listitem><para>Write binary policy to <emphasis role="italic">file</emphasis> (default: policy.<emphasis role="italic">version</emphasis>)</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-f, --filecontext=&lt;file></option></term>
> +            <listitem><para>Write file contexts to <emphasis role="italic">file</emphasis> (default: <emphasis role="bold">file_contexts</emphasis>)</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-t, --target=&lt;type></option></term>
> +            <listitem><para>Specify target architecture. May be <emphasis role="bold">selinux</emphasis> or <emphasis role="bold">xen</emphasis> (default: <emphasis role="bold">selinux</emphasis>)</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-M, --mls true|false</option></term>
> +            <listitem><para>Build an mls policy. Must be <emphasis role="bold">true</emphasis> or <emphasis role="bold">false</emphasis>. This will override the <emphasis role="bold">(mls <emphasis role="italic">boolean</emphasis></emphasis><emphasis role="bold">)</emphasis> statement if present in the policy.</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-c, --policyvers=&lt;version></option></term>
> +            <listitem><para>Build a binary policy with a given <emphasis role="italic">version</emphasis> (default: depends on the systems SELinux policy <emphasis role="italic">version</emphasis>, see <citerefentry><refentrytitle>sestatus</refentrytitle><manvolnum>8</manvolnum></citerefentry>)</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-U, --handle-unknown=&lt;action></option></term>
> +            <listitem><para>How to handle unknown classes or permissions. May be <emphasis role="bold">deny</emphasis>, <emphasis role="bold">allow</emphasis>, or <emphasis role="bold">reject</emphasis> (default: <emphasis role="bold">deny</emphasis>). This will override the <emphasis role="bold">(handleunknown <emphasis role="italic">action</emphasis></emphasis><emphasis role="bold">)</emphasis> statement if present in the policy.</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-D, --disable-dontaudit</option></term>
> +            <listitem><para>Do not add <emphasis role="bold">dontaudit</emphasis> rules to the binary policy.</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-P, --preserve-tunables</option></term>
> +            <listitem><para>Treat tunables as booleans.</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-N, --disable-neverallow</option></term>
> +            <listitem><para>Do not check <emphasis role="bold">neverallow</emphasis> rules.</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-v, --verbose</option></term>
> +            <listitem><para>Increment verbosity level.</para></listitem>
> +         </varlistentry>
> +
> +         <varlistentry>
> +            <term><option>-h, --help</option></term>
> +            <listitem><para>Display usage information.</para></listitem>
> +         </varlistentry>
> +      </variablelist>
>     </refsect1>
>  
>     <refsect1 id="see_also"><title>SEE ALSO</title>
> @@ -83,7 +107,7 @@
>        </para>
>        <para>HTML documentation describing the CIL language statements is available starting with <emphasis role="italic">docs/html/index.html</emphasis>.</para>
>        <para>PDF documentation describing the CIL language statements is available at: <emphasis role="italic">docs/pdf/CIL_Reference_Guide.pdf</emphasis>.</para>
> -      <para>There is a CIL Design Wiki at: <ulink url="http://userspace.selinuxproject.org/trac/wiki/CilDesign"></ulink> that describes the goals and features of the CIL language.</para>
> +      <para>There is a CIL Design Wiki at: <ulink url="http://github.com/SELinuxProject/cil/wiki"></ulink> that describes the goals and features of the CIL language.</para>

I suppose that wiki should also be integrated with the selinux repository wiki, since the cil repository is not committed to anymore.

>     </refsect1>
>  </refentry>
>  
> -- 
> 2.1.0
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJU7de2AAoJENAR6kfG5xmcq+gL/34QzDdfdkkBt2RhWQL7inoQ
D32V9hpNi19nQChkbQQLPE08B4OYfYBUpp/kbdLd2wP1U1I4E0oN3YNq720ZNo03
EffZ3BwB8ZD/D3dO4cOQUVqM5PCxpd6xX3PSPihI69GvRr49O7XFxD8cyeixIDFr
CrFuwr8YOKlRU1xdGgZ1KppHNiIyo3Md2VfSHVdI0aT1raiuSvTVADnBUpNVCDWj
bAZfeQiz0X/P+zfR7lUETL1FuR5XreqPFWH/vOKg7hP1pPkKoyzvBLLZiV/MD3zz
iKoGAUnzirSCpTf1p2tUwi2fuVqajq4fSFYFHs1P1Tv0k5fzQDMBzTlM2sxpg+wY
LFRIKEE382lAthY1ZquD3q8iqT2/i7q1GsJhRkkdQQ1fS0UUi9l+uJB7i9tnTyGs
cEuvZMBwdq8fT0yQqs/BodoutL9ZeOsp/iZYfh5ftBNhAe2wUcT/VBaRHcGdC426
2jsT5ii/2O1oVxqfAq1SLyWUuDi5j0m85T1BINSXrg==
=BTb4
-----END PGP SIGNATURE-----
