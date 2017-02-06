Subject: Re: [PATCH 3/8] policycoreutils/semodule: hide -Wwrite-strings
 warnings
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170205155820.29157-1-nicolas.iooss@m4x.org>
 <20170205155820.29157-3-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <70479ea3-a2c0-56d8-34f2-e9f25c814753@tycho.nsa.gov>
Date: Mon, 6 Feb 2017 10:57:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170205155820.29157-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/05/2017 10:58 AM, Nicolas Iooss wrote:
> When building with "clang -Wwrite-strings", the compiler complains about
> initializing a char* array (variable genhomedirconargv) with literal
> strings (which are in read-only memory).
>
> However the programs needs to use a non-const char* array in order to
> fake arguments of getopt_long() (called by parse_command_line()). Silent
> the compiler warnings by introducing casts to char*.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  policycoreutils/semodule/semodule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index ce048bc061b9..36686d0230a8 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -341,7 +341,7 @@ int main(int argc, char *argv[])
>  	int i, commit = 0;
>  	int result;
>  	int status = EXIT_FAILURE;
> -	char *genhomedirconargv[] = { "genhomedircon", "-B", "-n" };
> +	char *genhomedirconargv[] = { (char *)"genhomedircon", (char *)"-B", (char *)"-n" };
>  	create_signal_handlers();
>  	if (strcmp(basename(argv[0]), "genhomedircon") == 0) {
>  		argc = 3;
>

I think that I would prefer the following for this one:

diff --git a/policycoreutils/semodule/semodule.c 
b/policycoreutils/semodule/semodule.c
index ce048bc..c63a864 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -341,11 +341,11 @@ int main(int argc, char *argv[])
  	int i, commit = 0;
  	int result;
  	int status = EXIT_FAILURE;
-	char *genhomedirconargv[] = { "genhomedircon", "-B", "-n" };
+	const char *genhomedirconargv[] = { "genhomedircon", "-B", "-n" };
  	create_signal_handlers();
  	if (strcmp(basename(argv[0]), "genhomedircon") == 0) {
  		argc = 3;
-		argv=genhomedirconargv;
+		argv = (char **)genhomedirconargv;
  	}
  	parse_command_line(argc, argv);


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
