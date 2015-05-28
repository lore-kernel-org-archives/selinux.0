Message-ID: <55676C62.2010309@tycho.nsa.gov>
Date: Thu, 28 May 2015 15:28:34 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ted Toth <txtoth@gmail.com>
Subject: Re: postgresql policy
References: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
 <55676482.6000302@tycho.nsa.gov>
 <CAFPpqQGW=-pmSOfyppL1Q8uZLP=0ikpniQHRMUF-41dFXSdJiQ@mail.gmail.com>
In-Reply-To: <CAFPpqQGW=-pmSOfyppL1Q8uZLP=0ikpniQHRMUF-41dFXSdJiQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/28/2015 03:10 PM, Ted Toth wrote:
> Unfortunately it is the latter. Here's an example of what you can do:
> 
> CREATE TABLE reports (
>     id integer NOT NULL,
>     report json,
>     message_id integer NOT NULL,
>     location geometry(Point),
>         security_label text DEFAULT sepostgres_getpeercon()
> );
> 
> CREATE POLICY
>   check_report_insert_selinux ON reports FOR INSERT
>   WITH CHECK (sepostgres_check_row_perm(reports.security_label,
> sepostgres_getpeercon(), 'insert'));
> 
> CREATE POLICY
>   check_report_delete_selinux ON reports FOR DELETE
>   USING (sepostgres_check_row_perm(reports.security_label,
> sepostgres_getpeercon(), 'delete'));
> 
> CREATE POLICY
>   check_report_update_selinux ON reports FOR UPDATE
>   USING (sepostgres_check_row_perm(reports.security_label,
> sepostgres_getpeercon(), 'update'))
>   WITH CHECK (sepostgres_check_row_perm(reports.security_label,
> sepostgres_getpeercon(), 'update'));
> 
> CREATE POLICY
>   check_report_select_selinux ON reports FOR SELECT
>   USING (sepostgres_check_row_perm(sepostgres_getpeercon(),
> reports.security_label, 'select'));
> 
> I'm hoping that between DAC, postgresql DAC, selinux policy and RLS
> policy we can get something that's secure enough for our purposes.

Pardon my ignorance, but are the sepostgres_*() functions something you
have implemented or something in the existing sepgsl or postgres code?
